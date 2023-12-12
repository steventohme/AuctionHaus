import { createClient } from '@supabase/supabase-js'

process.env.SUPABASE_KEY = 'https://owlrgfnprlnaazotrtgs.supabase.co'
export const supabase = createClient('https://owlrgfnprlnaazotrtgs.supabase.co', '<your-anon-key>')