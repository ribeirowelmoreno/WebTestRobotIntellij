*** Settings ***
Resource         ../Resources/WebTestResource.robot
Test Setup       Open Browser
#Test Teardown    Close Browser
Library          String

*** Test Cases ***
#Test Case 1: Search an existant product
#  Given I'm in the home page
#  When I write the product name "Blouse" on the search field
#  And click on the search button
#  Then the "Blouse" product should be listed on the website
#
#Test Case 2: Search an non existant product
#  Given I'm in the home page
#  When I write the product name "nonExitentItem" on the search field
#  And click on the search button
#  Then the error message "No results were found for your search "nonExitentItem"" should be displayed
#
#Scenario 3: Pass the mouse on "Women" category on main menu
#  Given I'm in the home page
#  When I pass the mouse on the "Women" category
#  And click in the "Summer Dresses" sub-category
#  Then the "Summer Dresses" products should be displayed

#Scenario 4: Add product to cart
#  Given I'm in the home page
#  When I write the product name "t-shirt" on the search field
#  And click on the search button
#  And add it to the cart
#  Then the product should be displayed on the cart

#Scenario 5: Removing products from cart
#  Given I'm in the home page
#  When I write the product name "t-shirt" on the search field
#  And add it to the cart
#  And delete the recently added product
#  Then the recently added product should be deleted

Scenario 6: Add e new client
  Given I'm in the home page
  When I click on sign in button
  And insert a valid e-mail
  And click on "Create new account" button
  And fill the required fields
  And submit register
  Then the register should be successfully done