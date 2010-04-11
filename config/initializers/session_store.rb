# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_webshotgun_session',
  :secret      => '7e0881e285995f865be89afc1e23f269f0c2cf510ba511d3eebec490f94f181f785cff6783bfd27ef7c07603fd83ba4181e3cb4866b85c755262c1d11165db4c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
