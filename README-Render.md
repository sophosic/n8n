# n8n on Render

This repository contains configuration files for deploying n8n, a powerful workflow automation tool, to [Render](https://render.com).

## Deployment Instructions

### Prerequisites

- A Render account
- Git repository with the n8n configuration files (this repository)

### Deploy to Render

1. Fork or clone this repository
2. Log in to your Render dashboard
3. Click on "New" and select "Blueprint"
4. Connect your repository containing these configuration files
5. Render will detect the `render.yaml` file and set up:
   - A web service running n8n
   - A PostgreSQL database
   - A persistent disk for data storage

### Configuration

The `render.yaml` file configures:

- A web service running the n8n Docker image
- A PostgreSQL database for workflow storage
- A persistent disk mounted at `/home/node/.n8n` to store configuration data
- Required environment variables for n8n to function correctly

### Environment Variables

The following environment variables are automatically configured:

- `N8N_ENCRYPTION_KEY`: A random key generated by Render for encrypting credentials
- Database connection details from the Render PostgreSQL instance
- Execution data settings to manage workflow executions

### Custom Domain (Optional)

To use a custom domain:

1. Go to your n8n service in the Render dashboard
2. Navigate to the "Settings" tab
3. Add your custom domain under the "Custom Domains" section
4. Follow Render's instructions to verify domain ownership

### Webhook URLs

If you're using webhooks, you'll need to use your Render URL or custom domain. The URL will be in the format:

- `https://your-service-name.onrender.com/` or
- `https://your-custom-domain.com/`

## Troubleshooting

- **Database Connection Issues**: Verify the database connection settings in the Render dashboard
- **Persistent Disk Issues**: Ensure the disk is mounted at `/home/node/.n8n`
- **Service Not Starting**: Check the service logs in the Render dashboard for error messages

## Additional Resources

- [n8n Documentation](https://docs.n8n.io/)
- [Render Documentation](https://docs.render.com/)
- [n8n Environment Variables Reference](https://docs.n8n.io/hosting/configuration/environment-variables/)
