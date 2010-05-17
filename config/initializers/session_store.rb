# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_sitpass_session',
  :secret      => 'c6614470cf22f54677ceace0fdf71790523f933f46efed6a58aaa472aae624fda6f263755eb2ed8833d7c27baa2d776530ca65d434c7a06290599cfc1c892d8f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
