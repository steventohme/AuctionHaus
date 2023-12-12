import { createClient } from '@supabase/supabase-js'

const supabase_key = process.env.SUPABASE_KEY || ''
const supabase_url = process.env.SUPABASE_URL || ''
export const supabase = createClient(supabase_key, supabase_url)