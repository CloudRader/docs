---
title: Identity Provider & SSO
icon: lucide/shield-check
---

# Identity Provider & SSO :material-shield-key-outline:{ .main-color }

<span class="badge badge-cyan"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/></svg> OpenID Connect</span>
<span class="badge badge-green"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg> Single Sign-On</span>
<span class="badge badge-purple"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path></svg> Provider Agnostic</span>

The **CloudRader** ecosystem is **identity provider agnostic**. Rather than locking deployments into a single proprietary authentication system, all CloudRader applications authenticate users and verify API tokens using standard **OpenID Connect (OIDC)** and **OAuth 2.0**.

You can integrate CloudRader with any OIDC-compliant identity provider, including **Keycloak**, **Authentik**, **Authelia**, **Zitadel**, or managed corporate IdPs (such as Okta or Microsoft Entra ID).

---

## :material-key-chain: Why Central Identity?

Rather than maintaining separate user accounts and password databases in each service, CloudRader delegates identity to your central provider:

<div class="grid cards" markdown>

-   :material-login:{ .main-color } __Single Sign-On (SSO)__

    ---

    Users sign in once to access Reservium, Inventarium, and all future CloudRader tools without re-entering credentials.

-   :material-account-group:{ .main-color } __Centralized Administration__

    ---

    Provision accounts, reset passwords, and assign departmental groups in a single administrative portal.

-   :material-shield-lock:{ .main-color } __Standard OIDC & JWT Tokens__

    ---

    Applications verify cryptographically signed JSON Web Tokens (JWT) without touching plain-text user passwords.

-   :material-link-variant:{ .main-color } __Federation Support__

    ---

    Connect external identity providers such as Google Workspace, GitHub, Microsoft Entra ID, or existing LDAP/Active Directory servers.

</div>

---

## :material-cog-sync-outline: Standard OIDC Architecture & Roles

All CloudRader applications interact with identity providers through standardized protocols:

1. **Web Interface Authentication**: Single-page applications (SPAs) and web portals use the standard **Authorization Code Flow with PKCE** (Proof Key for Code Exchange) to obtain ID and access tokens securely in the browser.
2. **API Request Verification**: Backend services validate incoming `Bearer <token>` HTTP headers against the identity provider's JSON Web Key Set (JWKS) endpoint without transmitting credentials over internal networks.
3. **Role-Based Access Control (RBAC)**: Applications inspect token claims (such as `roles` or realm access) to enforce permissions.

### Common Application Roles

CloudRader services look for specific role claims in the validated access token:

| Application | Role Name | Permissions & Scope |
| :--- | :--- | :--- |
| **Reservium** | `reservium-user` | Browse rooms, view availability calendars, create reservations. |
| **Reservium** | `reservium-manager` | Approve or decline requests, manage room schedules and conflicts. |
| **Reservium** | `reservium-admin` | Manage spaces, categories, global settings, and configuration. |
| **Inventarium** | `inventarium-user` | Browse equipment catalog, scan QR codes, view assigned items. |
| **Inventarium** | `inventarium-manager` | Check-in/check-out assets, transfer custody, perform audits. |
| **Inventarium** | `inventarium-admin` | Manage item types, custom attributes, locations, and system settings. |

---

## :material-shield-star: Reference Implementation: Keycloak

While CloudRader works with any standard OIDC provider, **Keycloak** is included as the primary reference implementation in the [Quickstart Stack](quickstart-stack.md). Below is the complete step-by-step setup guide.

### :material-numeric-1-box-outline: Step 1. Log in to the Admin Console

1. Navigate to your Keycloak administrative URL (e.g., `http://localhost:8443` or `https://auth.example.com`).
2. Log in using the admin credentials defined in your `.env` file (`KEYCLOAK_ADMIN` and `KEYCLOAK_ADMIN_PASSWORD`).

### :material-numeric-2-box-outline: Step 2. Create the CloudRader Realm

It is recommended practice to leave the default `master` realm dedicated solely to Keycloak system administration and create a dedicated realm for your applications:

1. In the top-left realm dropdown (which displays `master`), click **Create realm**.
2. **Realm name**: Enter `cloudrader`.
3. Toggle **Enabled** to `ON`.
4. Click **Create**.

### :material-numeric-3-box-outline: Step 3. Create Application Clients

Each CloudRader service needs an OpenID Connect client registered in the `cloudrader` realm.

#### Configuring the Reservium Client

1. In the left navigation menu, click **Clients** -> **Create client**.
2. **General Settings**:
   - **Client type**: `OpenID Connect`
   - **Client ID**: `reservium-app`
   - **Name**: `Reservium Booking System`
   - Click **Next**.
3. **Capability Config**:
   - **Client authentication**: Toggle `ON` (confidential client).
   - **Authentication flow**: Check `Standard flow` and `Direct access grants`.
   - Click **Next**.
4. **Login Settings**:
   - **Root URL**: `https://reservium.example.com` (or `http://localhost:3000` for local dev)
   - **Home URL**: `/`
   - **Valid redirect URIs**: `https://reservium.example.com/*` (or `http://localhost:3000/*`)
   - **Valid post logout redirect URIs**: `https://reservium.example.com/*`
   - **Web origins**: `+` (inherits valid redirect URIs for CORS)
   - Click **Save**.
5. **Retrieve Client Secret**:
   - Open the **Credentials** tab on the client page.
   - Copy the value under **Client Secret** and save it into your `.env` file as `RESERVIUM_CLIENT_SECRET`.

### :material-numeric-4-box-outline: Step 4. Define Roles & Users

#### 1. Create Realm Roles
Navigate to **Realm roles** -> **Create role** to define permissions recognized by CloudRader services:

- `reservium-user`
- `reservium-manager`
- `reservium-admin`

#### 2. Create a User Account
1. In the left menu, navigate to **Users** -> **Add user**.
2. Fill in **Username**, **Email**, **First name**, and **Last name**.
3. Toggle **Email verified** to `ON` and click **Create**.
4. Switch to the **Credentials** tab, click **Set password**, enter a password, and toggle **Temporary** to `OFF`.
5. Switch to the **Role mapping** tab, click **Assign role**, and select the desired roles (e.g., `reservium-user` and `reservium-manager`).

### :material-code-brackets: Step 5. Connect CloudRader Services

In your deployment `.env` or container configuration, supply the matching connection parameters:

```bash
# OIDC / Keycloak Connection Parameters for Reservium
KEYCLOAK__SERVER_URL=https://auth.example.com
KEYCLOAK__REALM=cloudrader
KEYCLOAK__CLIENT_ID=reservium-app
KEYCLOAK__CLIENT_SECRET=your_copied_secret_here
```

Restart the application container to apply the settings:

```bash
docker compose up -d --force-recreate reservium-api
```

---

## :material-transit-connection-variant: Other Identity Providers

Because CloudRader relies on standard OIDC, integrating another provider requires only registering an OIDC client and configuring the corresponding issuer endpoint:

<div class="grid cards" markdown>

-   :material-shield-account:{ .main-color } __Authentik__

    ---

    Create an OAuth2/OpenID Provider and Application in Authentik, set the redirect URIs to your service domain, and map groups to the standard role names.

-   :material-shield-lock-outline:{ .main-color } __Authelia__

    ---

    Define an OpenID Connect client in Authelia's `configuration.yml` specifying the client ID, hashed secret, and allowed callback URLs.

-   :material-cloud-lock-outline:{ .main-color } __Zitadel__

    ---

    Create a project and application in Zitadel, enable authorization code flow with PKCE, and assign service roles through Zitadel authorizations.

-   :material-domain:{ .main-color } __Managed Corporate IdPs__

    ---

    Connect directly with Okta, Microsoft Entra ID (Azure AD), or Google Workspace using standard enterprise OIDC application registrations.

</div>

---

## :material-bug-outline: Troubleshooting & Common Pitfalls

!!! tip "Common Issues and Resolutions"
    - **`Invalid parameter: redirect_uri`**: Ensure the exact protocol, domain, port, and trailing path match what is listed under **Valid redirect URIs** in your identity provider. Wildcards (e.g., `https://reservium.example.com/*`) are supported in Keycloak.
    - **HTTPS & Mixed Content Behind Reverse Proxy**: When terminating TLS at Caddy or Traefik, ensure proxy headers (`X-Forwarded-Proto: https` and `X-Forwarded-Host`) are forwarded so the identity provider does not construct `http://` redirect URLs.
    - **CORS Errors in Browser Console**: Verify that **Web origins** contains `+` or the exact origin (e.g. `https://reservium.example.com`).
    - **Token Signature Verification Failure**: Ensure the backend container can resolve and reach the identity provider's discovery URL (`/.well-known/openid-configuration`) over the Docker network or public internet.