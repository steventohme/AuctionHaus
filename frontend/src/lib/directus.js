import { createDirectus } from '@directus/sdk';

// TODO: change to environment variable
const directus = createDirectus('https://your-directus-instance.com');

export default directus;
