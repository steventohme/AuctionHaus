import { createClient } from '@supabase/supabase-js'

const supabase_key = process.env.SUPABASE_KEY = 'https://owlrgfnprlnaazotrtgs.supabase.co'
export const supabase = createClient('https://owlrgfnprlnaazotrtgs.supabase.co', '<your-anon-key>')