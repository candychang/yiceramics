
$(document).on 'ready page:load', ->
    braintree.setup(gon.client_token, 'dropin', { container: 'dropin-container' });