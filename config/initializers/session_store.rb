# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_DRESSCODE_session',
  :secret      => '74ea8eb7abd26cc8ec1b4ef135294c0e45f1762a3471d3713f76b58c085c4c38e571a9582037da0a8739aa90588942b0331ee557e1d8de197fa7ad0b7f4b7a07'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
