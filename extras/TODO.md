When you're ready to add Cloudflare Tunnels for an extra layer of security (which is a great idea as it hides your server's IP address), you can integrate it with Caddy.

You would typically run the cloudflared daemon in another Docker container and configure it to point to your Caddy instance. Your Caddyfile would then be simplified as it would only need to handle local traffic from the cloudflared container.

Here's a conceptual overview of the changes:
1. Install cloudflared: You can add another service to your docker-compose.yml for cloudflared.
2. Configure the Tunnel: You'll create a tunnel in your Cloudflare dashboard and get a token.
3. Update Caddy: Your Caddyfile will listen on a local port that cloudflared forwards to.


Note the use of expose for n8n and PowerShell Universal. This makes their ports accessible only to other containers on the same Docker network (like Caddy), but not to the public internet, which is a more secure pattern.

execute playbook: ansible-playbook playbook.yml


Next Steps: Cloudflare Tunnel Integration
Using a Cloudflare Tunnel is an excellent way to further secure your setup by hiding your server's origin IP address.[9][10][11]
Create a Tunnel: In your Cloudflare Zero Trust dashboard, navigate to Access > Tunnels and create a new tunnel.
Get the Token: Cloudflare will provide a token for the tunnel connector.
Add cloudflared to Docker Compose: Add a new service to your docker-compose.yml.j2 file for the cloudflared connector, using the token you just received.
Configure Public Hostnames: In the Cloudflare dashboard, configure the public hostnames (e.g., n8n.your-domain.com) to point to the Caddy service (e.g., http://caddy:80).
Lock Down the Firewall: Once the tunnel is active and routing traffic, you can update your hardening role in Ansible to remove the rules allowing public access on ports 80 and 443, making your server completely inaccessible directly from the internet.

# Vagrant
May want to look into UTM, parallels or VMWare Fusion for working with Vagrant as opposed to Docker containers.


# Docker hardening
https://github.com/dev-sec/hardening/tree/master/ansible-linux

# Learn Tags
# Set States
