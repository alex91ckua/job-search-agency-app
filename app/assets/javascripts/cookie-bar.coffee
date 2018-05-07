cookiesAllowed = null

allowCookies = ->
  Cookies.set 'allow_cookies', 'yes', expires: 365
  jQuery('#cookies-bar').fadeOut(250)
  return

declineCookies = ->
  Cookies.set 'allow_cookies', 'no', expires: 365
  jQuery('#cookies-bar').fadeOut(250)
  return

ready = ->
  cookiesAllowed = Cookies.get('allow_cookies')

  allowCookies if cookiesAllowed == 'yes'

  # allow cookies by clicking on any link (including the cookies bar button)
  jQuery('a#accept-cookies').on 'click', (e) ->
    allowCookies()

  jQuery('a#decline-cookies').on 'click', (e) ->
    declineCookies()

jQuery(document).ready ready
jQuery(document).on 'page:load', ready
jQuery(document).on 'turbolinks:load', ready