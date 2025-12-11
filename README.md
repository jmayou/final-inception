*This project has been created as part of the 42 curriculum by jmayou.*

# Inception

## Description
Inception builds a minimal yet production-like web stack using Docker Compose. Each service (NGINX, MariaDB, WordPress with PHP-FPM) has its own Dockerfile, runs in its own container, and communicates over a dedicated user-defined network. Data and site files are persisted under `/home/<login>/data` to survive container rebuilds. TLS is terminated at NGINX, which is the only public entrypoint.

## Instructions
- Build images: `make build`
- Start the stack: `make up`
- Stop the stack: `make down`
- Clean containers/images/networks/volumes: `make fclean` (this also clears `/home/<login>/data`)
- View logs: `make logs`

Before running, copy `srcs/.env.example` to `srcs/.env`, set the required values (replace every `CHANGE_ME`), and ensure `WP_ADMIN_USER` does not contain the substring `admin`.

## Resources
- Docker docs: https://docs.docker.com/
- NGINX docs: https://nginx.org/en/docs/
- MariaDB docs: https://mariadb.com/kb/en/documentation/
- WordPress docs: https://developer.wordpress.org/
- AI usage: ChatGPT assisted with refactoring configuration naming, enforcing admin-user rules, and producing this README; all changes were reviewed and integrated into the repository.

## Project Comparisons
- Virtual Machines vs Docker: VMs virtualize hardware and run full guest OS instances; they are heavier but isolate kernels. Docker uses OS-level isolation (namespaces/cgroups), sharing the host kernel for lighter footprint, faster startup, and easier image distribution.
- Secrets vs Environment Variables: Environment variables are convenient for configuration but are visible to processes and often committed by mistake. Secrets (or external secret stores) are the preferred way to provide sensitive data at runtime without writing them into images or VCS; when secrets are unavailable, `.env` should stay untracked and contain placeholders only.
- Docker Network vs Host Network: A user-defined bridge network isolates containers, provides built-in DNS, and avoids host port conflicts. Host networking removes isolation and binds directly to the host stack, which is unsuitable here because services must remain encapsulated and talk over the internal Compose network.
- Docker Volumes vs Bind Mounts: Named volumes are managed by Docker and resilient across container rebuilds; bind mounts map host paths directly and are useful for development or when a specific host directory must persist (as with `/home/<login>/data` in this project). Here the bind-mount approach makes persistent data explicit for evaluation.

## Helpful Notes
- Data paths: `/home/<login>/data/mariadb` for the database, `/home/<login>/data/shared` for WordPress files (substitute your 42 login).
- Network: all containers join `inception_net`; only NGINX publishes port 443 to the host.
- TLS: self-signed certificates are generated at container start; TLS protocols are restricted to TLSv1.2/TLSv1.3.
- WordPress credentials: the admin account uses `WP_ADMIN_USER`/`WP_ADMIN_PASSWORD`; the site runs with `MYSQL_USER`/`MYSQL_PASSWORD` for database access and an additional author user defined by `USER`/`USER_PASSWORD`.
# final-inception
