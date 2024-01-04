
import { useState, useEffect } from 'react'
import { createClient, getSession } from '@/utils/supabase/server'

export default async function Profile() {
  'use server'
  const session = await getSession()
  return (
    <div>
      <h1>Profile</h1>
      <p>ID: {session?.user.id}</p>
      <p>Email: </p>
      <p>Created at:</p>
      {/* Add more fields as needed */}
      <button>
        Edit Profile
      </button>
    </div>
  )
}