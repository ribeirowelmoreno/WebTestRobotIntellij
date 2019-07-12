*** Settings ***
Library    Selenium2Library
Library    String

*** Variables ***
${BROWSER}              firefox
${URL}                  http://automationpractice.com
${SITE_TITLE}           My Store
${ADD_TO_CART_BUTTON}   Add to cart
${PEOPLE_DATA}          first_name=Jose     last_name=Silva     password=jose2012?01        day_of_birth=10     month_of_birth=8        year_of_birth=1991      address=Rua Aguaçu, 171     city=Campinas       state=16        post_code=34711     country=21      phone_number=19999999999

*** Keywords ***
# SETUP e TEARDOWN
Open Browser
  Selenium2Library.Open Browser     about:blank    ${BROWSER}

Close Browser
  Selenium2Library.Close Browser

###Actions###
Given I'm in the home page
  go to             http://automationpractice.com
  maximize browser window
  title should be   ${SITE_TITLE}

When I write the product name "${PRODUCT}" on the search field
  input text        name=search_query       ${PRODUCT}

And click on the search button
  click element     name=submit_search

When I pass the mouse on the "${CATEGORY_TYPE}" category
  wait until element is visible   xpath=//*[@id="block_top_menu"]//a[@title="${CATEGORY_TYPE}"]
  mouse over                      xpath=//*[@id="block_top_menu"]//a[@title="${CATEGORY_TYPE}"]

And click in the "${SUB_CATEGORY_TYPE}" sub-category
  wait until element is visible   xpath=//*[@id="block_top_menu"]//a[@title="${SUB_CATEGORY_TYPE}"]
  click element                   xpath=//*[@id="block_top_menu"]//a[@title="${SUB_CATEGORY_TYPE}"]

And add it to the cart
  wait until element is visible         xpath=//*[@id="center_column"]//img[@alt="Faded Short Sleeve T-shirts"]
  click element                         xpath=//*[@id="center_column"]//img[@alt="Faded Short Sleeve T-shirts"]
  execute javascript                    window.scrollTo(0,300);
  wait until element is visible         xpath=//*[@id="add_to_cart"]/button
  click element                         xpath=//*[@id="add_to_cart"]/button
  wait until element is visible         xpath=//*[@id="layer_cart"]//a[@title="Proceed to checkout"]
  click element                         xpath=//*[@id="layer_cart"]//a[@title="Proceed to checkout"]

And delete the recently added product
  wait until element is visible         xpath=//*[@id="1_1_0_0"][@title="Delete"]
  click element                         xpath=//*[@id="1_1_0_0"][@title="Delete"]

When I click on sign in button
  wait until element is visible         xpath=//*[@id="header"]/div[2]//a[@class="login"]
  click element                         xpath=//*[@id="header"]/div[2]//a[@class="login"]

Create a random e-mail
  [Arguments]           ${NAME}     ${LAST_NAME}
  ${RANDOM_STRING}      generate random string
  ${CUSTOM_EMAIL}       set variable    ${NAME}${LAST_NAME}${RANDOM_STRING}@testrobot.com
  log                   ${CUSTOM_EMAIL}
  [Return]              ${CUSTOM_EMAIL}

And insert a valid e-mail
  wait until element is visible            id=email_create
  ${EMAIL}     Create a random e-mail      ${PEOPLE_DATA.first_name}        ${PEOPLE_DATA.last_name}
  input text                               id=email_create      ${EMAIL}


###Assertions###
Then the "${PRODUCT}" product should be listed on the website
  wait until element is visible   css=.page-heading
  title should be                 Search - ${SITE_TITLE}
  page should contain image       xpath=//*[@id="center_column"]//img[@src="http://automationpractice.com/img/p/7/7-home_default.jpg"]
  page should contain link        xpath=//*[@id="center_column"]//a[@class="product-name"][contains(text(), "${PRODUCT}")]

Then the error message "${ERROR_MESSAGE}" should be displayed
  wait until element is visible   xpath=//*[@id="center_column"]//p[@class="alert alert-warning"]
  element text should be          xpath=//*[@id="center_column"]//p[@class="alert alert-warning"]    ${ERROR_MESSAGE}

Then the "Summer Dresses" products should be displayed
  wait until element is visible   xpath=//*[@id="center_column"]/h1/span[1][@class="cat-name"]
  page should contain image       xpath=//*[@id="center_column"]//img

Then the product should be displayed on the cart
  page should contain element     xpath=//*[@id="header"]//a[@title="View my shopping cart"]
  page should contain element     xpath=//*[@id="product_1_1_0_0"]//p[@class="product-name"]

Then the recently added product should be deleted
  page should contain element     xpath=//*[@id="center_column"]/p[@class="alert alert-warning"][contains(text(), "Your shopping cart is empty")]

