*** Settings ***
Library    Selenium2Library

*** Variables ***
${BROWSER}      firefox
${URL}          http://automationpractice.com
${SITE_TITLE}   My Store

*** Keywords ***
# SETUP e TEARDOWN
Open Browser
  Selenium2Library.Open Browser     about:blank    ${BROWSER}

Close Browser
  Selenium2Library.Close Browser

###Actions###
Access home page
  go to             http://automationpractice.com
  maximize browser window
  title should be   ${SITE_TITLE}

Write the product name "${PRODUCT}" on the search field
  input text        name=search_query       ${PRODUCT}

Click on the search button
  click element     name=submit_search

When I pass the mouse on the "${CATEGORY_TYPE}" category
  wait until element is visible  xpath=//*[@id="block_top_menu"]//a[@title="${CATEGORY_TYPE}"]
  mouse over  xpath=//*[@id="block_top_menu"]//a[@title="${CATEGORY_TYPE}"]

Click in the "${CATEGORY_TYPE}" sub-category
  wait until element is visible  xpath=//*[@id="block_top_menu"]//a[@title="${CATEGORY_TYPE}"]
  click element  xpath=//*[@id="block_top_menu"]//a[@title="${SUB_CATEGORY_TYPE}"]

###Assertions###
Make sure ir the "Blouse" product was listed on the website
  wait until element is visible  css=.page-heading
  title should be  Search - ${SITE_TITLE}
  page should contain image  xpath=//*[@id="center_column"]//img[@src="http://automationpractice.com/img/p/7/7-home_default.jpg"]
  page should contain link   xpath=//*[@id="center_column"]//a[@class="product-name"][contains(text(), "Blouse")]

Check error message "${ERROR_MESSAGE}" was displayed
  wait until element is visible  xpath=//*[@id="center_column"]//p[@class="alert alert-warning"]
  element text should be         xpath=//*[@id="center_column"]//p[@class="alert alert-warning"]    ${ERROR_MESSAGE}