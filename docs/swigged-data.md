# Swigged API

Built with GraphQL API, Hasura, and Postgres Database. Swigged API serves data to Swigged's web app. Token authentication prevents anonymous users from interacting with the API, and allows authorized users to only interact with data that pertains to them.

## Endpoints

```javascript
{
    "user": "/api/user/",
    "user-cocktails": "/api/users-cocktails/",
    "user-favorite": "/api/user-favorite/",
    "user-products": "/api/user-products/",
    "user-shopping": "/api/user-shopping/",
    "team": "/api/teams/",
    "cocktails": "/api/cocktails/",
    "cocktailingredients": "/api/cocktailingredients/",
    "products": "/api/products/",
    "ingredients": "/api/ingredients/",
    "spirits": "/api/spirit/",
    "tags": "/api/tags/",
}
```

---

## Overview

TABLE user
user_ID - A unique ID per user. Can be joined to user_id in either of the other tables.
first_name,
last_name,
email,
user_name,
password,
profile_picture,
created_at - The time the user was created (first signed up)
state -	The state of the user (active or pending)
activated_at - The time the user was activated, if they are active
Foreign Keys:
userCocktailID - an user can have many userCocktail; an userCocktail can have one user
userFavoriteID - an user can have many userFavorite; an userFavorite can have one user
userProductID - an user can have many userProduct; an userProduct can can have one user
userShoppingWishID - an user can have many userShoppingWish; an userShoppingWish can have one user

### /api/user

Includes all information necessary to display a user.

```javascript
{
    "id":
    "userName":
    "email":
    "password":
    "profilePicture":
}
```

---

user_cocktail:
user_cocktail_ID,
user_ID,
cocktail_ID,
date_modified,
is_public,
comments,
comments_count,
comments_enabled,
is_active,
Foreign Keys:
cocktailID - an userCocktail can have many cocktail; a cocktail can have many userCocktail
userId - an userCocktail can have one user; an user can have many userCocktail

### /api/user_cocktails/

Returns the current user's saved cocktails. Cocktail and ingredients are embedded in the request. Requires token.

Allowed: `GET`, `POST`, `PUT`, `PATCH`, `DELETE`

```javascript
{
  "id": 20,
  "cocktail": {
    "id": 1,
    "ingredients": [
      {
        "ingredient": {
          "name": "Gin",
          "id": 1,
          "liquid": true
        },
        "sort_order": 1,
        "amount": "0.75",
        "unit": "oz"
      },
      {
        "ingredient": {
          "name": "Green Chartreuse",
          "id": 2,
          "liquid": true
        },
        "sort_order": 2,
        "amount": "0.75",
        "unit": "oz"
      },
      {
        "ingredient": {
          "name": "Maraschino Liqueur",
          "id": 3,
          "liquid": true
        },
        "sort_order": 3,
        "amount": "0.75",
        "unit": "oz"
      },
      {
        "ingredient": {
          "name": "Lime Juice",
          "id": 4,
          "liquid": true
        },
        "sort_order": 4,
        "amount": "0.75",
        "unit": "oz"
      }
    ],
    "name": "Last Word",
    "instructions": "Shake with ice and strain into a chilled coupe.",
    "notes": "This is a really good cocktail.",
    "created_by": 1
  },
  "cocktail_id": 1,
  "is_saved": true,
  "make_count": 4,
  "user": 1
}
```

---

user_favorite:
user_favorite_ID,
user_ID,
cocktail_ID.
Foreign Keys:
userId - an userFavorite can have one user; an user can have many userFavorite
cocktailId - an userFavorite can have many cocktail; a cocktail can have many userFavorite

### /api/user_favorite/

Returns cocktails a user has queued to make. Cocktail information is embedded in the request. Token required.

Allowed: `GET`, `POST`, `PUT`, `PATCH`, `DELETE`

```javascript
{
  "id": 15,
  "cocktail": {
    "id": 1,
    "ingredients": [
      {
        "ingredient": {
          "name": "Gin",
          "id": 1,
          "liquid": true
        },
        "sort_order": 1,
        "amount": "0.75",
        "unit": "oz"
      },
      {
        "ingredient": {
          "name": "Green Chartreuse",
          "id": 2,
          "liquid": true
        },
        "sort_order": 2,
        "amount": "0.75",
        "unit": "oz"
      },
      {
        "ingredient": {
          "name": "Maraschino Liqueur",
          "id": 3,
          "liquid": true
        },
        "sort_order": 3,
        "amount": "0.75",
        "unit": "oz"
      },
      {
        "ingredient": {
          "name": "Lime Juice",
          "id": 4,
          "liquid": true
        },
        "sort_order": 4,
        "amount": "0.75",
        "unit": "oz"
      }
    ],
    "name": "Last Word",
    "instructions": "Shake with ice and strain into a chilled coupe.",
    "notes": "This is a really good cocktail.",
    "created_by": 1
  },
  "cocktail_id": 1,
  "quantity": 1,
  "user": 1
}
```

---

user_product:
user_product_ID,
user_ID,
product_ID,
amount_available.
Foreign Keys:
userId - an userProduct can have one user; an user can have many userProduct
productId - an userProduct can have many product; a product can have one userProduct

### /api/user_products/

Returns products that a user has in their inventory. Product information is embedded in the request. Token required.

Allowed: `GET`, `POST`, `PUT`, `PATCH`, `DELETE`

```javascript
{
  "id": 22,
  "quantity": 1,
  "product": {
    "id": 17,
    "name": "Campari 2",
    "size": 750,
    "unit": "ml",
    "ingredient": 5,
    "created_by": 1
  },
  "product_id": 17,
  "user": 1,
  "amount_available": "586.00"
}
```

---

user_shopping_wish:
user_shopping_wish_ID,
user_ID,
product_ID,
quantity,
ingredient_ID.
Foreign Keys:
userId - an userShoppingWish can have one user; an user can have many userShoppingWish
productId - an userShoppingWish can have many product; a product can have one userShoppingWish
ingredientId - an userShoppingWish can have many ingredient; an ingredient can have one userShoppingWish

### /api/user_shopping_wish/

Returns products and ingredients that are in a user's inventory. Ingredient/Product information is embedded in the request. Token required.

Allowed: `GET`, `POST`, `PUT`, `PATCH`, `DELETE`

```javascript
{
  "id": 20,
  "product": null,
  "product_id": null,
  "ingredient": {
    "name": "Green Chartreuse",
    "id": 2,
    "liquid": true
  },
  "ingredient_id": 2,
  "quantity": 1,
  "user": 1
},
{
  "id": 21,
  "product": {
    "id": 17,
    "name": "Campari 2",
    "size": 750,
    "unit": "ml",
    "ingredient": 5,
    "created_by": 1
  },
  "product_id": 17,
  "ingredient": null,
  "ingredient_id": null,
  "quantity": 1,
  "user": 1
}
```

---

team:
team_ID,
user_ID
team_title,
permissions,
Foreign Keys: An User could have many teams; a single team could only have on of the same User.

### /api/team

Includes all information necessary to display a team.

```javascript
{
    "team_id":
    "team_title":
    "permissions":
}
```

---

cocktail:
cocktail_ID,
cocktail_type,
cocktail_name,
cocktail_category,
IBA,
glass_type,
instruction,
image_URL,
cocktailIngredientId - a cocktail can have many cocktailIngredient; cocktailIngredient can have one cocktail
alcoholic,
isActive,

created_by_ID,
date_created.
Foreign Keys:
userCocktailId - a cocktail can have one userCocktail; an userCocktail can have many cocktails
createdById - a cocktail can have one createdById; that createdById is one userId

### /api/cocktails

Includes all information necessary to display a cocktail, including ingredients.

Allowed: `GET`, `POST`, `PUT`, `PATCH`, `DELETE`

```javascript
{
    id: 11000,
    type: 'cocktail',
    name: 'A Furlong Too Late',
    category: 'Ordinary Drink',
    IBA: null,
    glass: 'Highball Glass',
    instructions:
      'Pour the rum and ginger beer into a Highball Glass almost filled with ice cubes. Stir well. Garnish with the lemon twist.',
    image: '',
    ingredients: [
      {
        product: 'Light rum',
        unit: 'cl',
        amount: 6,
      },
      {
        product: 'Ginger beer',
        unit: 'cl',
        amount: 12,
      },
      {
        product: 'Lemon peel',
        unit: 'twist of',
        amount: 1,
      },
    ],
    alcoholic: true,
  isActive: true,
}
```

---

product:
product_ID,
product_title,
product_type_name,
product_class_name,
product_sub_class_name,
product_minor_class_name,
product_country_origin_name,
product_sku_num,
product_long_name,
product_base_upc_num,
product_litres_per_container,
product_container_per_sell_unit,
product_alcohol_percent,
current_display_price,
sweetness_code,
ingredient_ID,
added_by_ID.
Foreign Keys:
ingredientID - a product could have one ingredient; and ingredient could have one product
addedBy - a product could have one user; and user could have many addedBy

### /api/products/

Returns information about products

Allowed: `GET`, `POST`, `PUT`, `PATCH`, `DELETE`

```javascript
{
  "id": 16,
  "name": "Another Gin",
  "size": 750,
  "unit": "ml",
  "ingredient": 1,
  "created_by": 1
},
```

---

cocktail_ingredient:
cocktail_ingredient_ID,
cocktail_ID,
ingredient_ID,
sort_order,
amount,
unit,
is_required.
Foreign Keys:
cocktailId - cocktailIngredient have one to many relation to cocktail;
ingredientId - one to many relation to ingredients.

### /api/cocktailingredients/

Returns relationships between cocktails and ingredients with ingredient information embedded.

Allowed: `GET`, `POST`, `PUT`, `PATCH`, `DELETE`

```javascript
{
  "ingredient": {
    "name": "Gin",
    "id": 1,
    "liquid": true
  },
  "sort_order": 1,
  "amount": "0.75",
  "unit": "oz"
}
```

---

ingredient:
ingredient_ID,
product,
unit,
amount
An ingredient is a product with a measurement.

### /api/ingredients/

Returns ingredient information.

Allowed: `GET`, `POST`, `PUT`, `PATCH`, `DELETE`

```javascript
{
  product: 'Light rum',
  unit: 'cl',
  amount: 6,
}
```

spirit:
spirit_ID,
product_ID,
distiller,
presentation_notes,
variety,
barrel_type,
age,
origin,
proof,
tasting_notes,
similar_in_profile,
food_pairings.
Foreign Keys:
product_ID - spirit has one to one relation to productID;

### /api/spirits/

Returns ingredient information.

Allowed: `GET`, `POST`, `PUT`, `PATCH`, `DELETE`

```javascript
{
  "name": "Campari",
  "id": 5,
  "liquid": true
}
```

tag:
tag_id,
tag_label,
cocktail_ID

### /api/tags/

Returns ingredient information.

Allowed: `GET`, `POST`, `PUT`, `PATCH`, `DELETE`

```javascript
{
  "name": "Campari",
  "id": 5,
  "liquid": true
}
```

---

### /api/user_shopping/

Returns products and ingredients that are in a user's inventory. Ingredient/Product information is embedded in the request. Token required.

Allowed: `GET`, `POST`, `PUT`, `PATCH`, `DELETE`

```javascript
{
  "id": 20,
  "product": null,
  "product_id": null,
  "ingredient": {
    "name": "Green Chartreuse",
    "id": 2,
    "liquid": true
  },
  "ingredient_id": 2,
  "quantity": 1,
  "user": 1
},
{
  "id": 21,
  "product": {
    "id": 17,
    "name": "Campari 2",
    "size": 750,
    "unit": "ml",
    "ingredient": 5,
    "created_by": 1
  },
  "product_id": 17,
  "ingredient": null,
  "ingredient_id": null,
  "quantity": 1,
  "user": 1
}
```

—-

Volume[edit]

- centiliter (cl)
- fluid ounce (also fl oz)

- teaspoon (also t or tsp.)
- tablespoon (also T, tbl., tbs., or tbsp.)
- gill (about 1/2 cup)
- cup (also c)
- pint (also p, pt, or fl pt - Specify Imperial or US)
- quart (also q, qt, or fl qt - Specify Imperial or US)
- gallon (also g or gal - Specify Imperial or US)
- ml, also milliliter, millilitre, cc (and mL only in the US, Canada and Australia).
- l, also liter, litre, (and L only in the US, Canada and Australia).
- dl, also deciliter, decilitre (and dL only in the US, Canada and Australia).
  Mass and Weight[edit]
- pound (also lb or #)
- ounce (also oz)
- mg (also milligram or milligramme)
- g (also gram or gramme)
- kg (also kilogram or kilogramme)
  Length[edit]
- mm (also millimeter or millimetre)
- cm (also centimeter or centimetre)
- m (also meter or metre)
- inch (also in or ")

This table name in Mode is tutorial.yammer_events	
user_id:	The ID of the user logging the event. Can be joined to user\_id in either of the other tables.
occurred_at:	The time the event occurred.
event_type:	The general event type. There are two values in this dataset: "signup_flow", which refers to anything occuring during the process of a user's authentication, and "engagement", which refers to general product usage after the user has signed up for the first time.
event_name:	The specific action the user took. Possible values include: create_user: User is added to Yammer's database during signup process enter_email: User begins the signup process by entering her email address enter_info: User enters her name and personal information during signup process complete_signup: User completes the entire signup/authentication process home_page: User loads the home page like_message: User likes another user's message login: User logs into Yammer search_autocomplete: User selects a search result from the autocomplete list search_run: User runs a search query and is taken to the search results page search_click_result_X: User clicks search result X on the results page, where X is a number from 1 through 10. send_message: User posts a message view_inbox: User views messages in her inbox
location:	The country from which the event was logged (collected through IP address).
device:	The type of device used to log the event.
	
Table 3: Email Events	
This table contains events specific to the sending of emails. It is similar in structure to the events table above.	
	
This table name in Mode is tutorial.yammer_emails	
user_id:	The ID of the user to whom the event relates. Can be joined to user_id in either of the other tables.
occurred_at:	The time the event occurred.
action:	The name of the event that occurred. "sent_weekly_digest" means that the user was delivered a digest email showing relevant conversations from the previous day. "email_open" means that the user opened the email. "email_clickthrough" means that the user clicked a link in the email.
	
Table 4: Rollup Periods	
The final table is a lookup table that is used to create rolling time periods. Though you could use the INTERVAL() function, creating rolling time periods is often easiest with a table like this. You won't necessarily need to use this table in queries that you write, but the column descriptions are provided here so that you can understand the query that creates the chart shown above.	
	
This table name in Mode is benn.dimension_rollup_periods	
period_id:	This identifies the type of rollup period. The above dashboard uses period 1007, which is rolling 7-day periods.
time_id:	This is the identifier for any given data point — it's what you would put on a chart axis. If time_id is 2014-08-01, that means that is represents the rolling 7-day period leading up to 2014-08-01.
pst_start:	The start time of the period in PST. For 2014-08-01, you'll notice that this is 2014-07-25 — one week prior. Use this to join events to the table.
pst_end:	The start time of the period in PST. For 2014-08-01, the end time is 2014-08-01. You can see how this is used in conjunction with pst_start to join events to this table in the query that produces the above chart.
utc_start:	The same as pst_start, but in UTC time.
pst_start:	The same as pst_end, but in UTC time.
