CREATE TABLE "user" (
  "user_ID"  serial  UNIQUE,
  "first_name"  varchar  NOT NULL,
  "last_name"  varchar  NOT NULL,
  "email"  varchar  NOT NULL  UNIQUE,
  "user_name"  varchar  NOT NULL  UNIQUE,
  "password"  varchar  NOT NULL  UNIQUE,
  "profile_picture"  varchar,
  "create_location" varchar NOT NULL,
  "create_time" DATE NOT NULL DEFAULT CURRENT_DATE,
  "state"  varchar  NOT NULL,
  "activated_at" DATE NOT NULL DEFAULT CURRENT_DATE,
  CONSTRAINT user_pk PRIMARY KEY ("user_ID")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "user_cocktail" (
  "user_cocktail_ID"  serial  UNIQUE,
  "user_ID"  serial  NOT NULL,
  "cocktail_ID"  serial  NOT NULL,
  "is_public"  boolean  NOT NULL,
  "date_modified"  varchar  NOT NULL,
  "comments"  varchar,
  "comments_count"  varchar,
  "comments_enabled"  boolean  NOT NULL,
  CONSTRAINT user_cocktail_pk PRIMARY KEY ("user_cocktail_ID")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "cocktail" (
  "cocktail_ID"  serial  UNIQUE,
  "cocktail_type" varchar,
  "cocktail_name"  varchar,
  "cocktail_category" varchar,
  "cocktail_IBA" varchar,
  "glass_type"  varchar,
  "instructions"  varchar,
  "description"  varchar,
  "image_URL"  varchar,
  "created_by_ID"  serial  NOT NULL,
  "date_modified"  varchar  NOT NULL,
  CONSTRAINT cocktail_pk PRIMARY KEY ("cocktail_ID")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "cocktail_ingredient" (
  "cocktail_ingredient_ID"  serial  UNIQUE,
  "cocktail_ID"  serial,
  "ingredient_ID"  serial  UNIQUE  NOT NULL,
  "sort_order"  varchar,
  "amount"  integer,
  "unit"  varchar,
  "is_required"  boolean  NOT NULL,
  CONSTRAINT cocktail_ingredient_pk PRIMARY KEY ("cocktail_ingredient_ID")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "ingredient" (
  "ingredient_ID"  serial  UNIQUE,
  "ingredient_title"  varchar,
  "unit"  varchar,
  "amount"  varchar,
  CONSTRAINT ingredient_pk PRIMARY KEY ("ingredient_ID")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "product" (
  "product_ID"  serial  UNIQUE,
  "product_title"  varchar,
  CONSTRAINT product_pk PRIMARY KEY ("product_ID")
) WITH (
  OIDS=FALSE
);














CREATE TABLE "user_favorite" (
  "user_favorite_ID"  serial  UNIQUE,
  "user_ID"  serial  NOT NULL,
  "cocktail_ID"  serial  NOT NULL,
  CONSTRAINT user_favorite_pk PRIMARY KEY ("user_favorite_ID")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "user_product" (
  "user_product_ID"  serial  UNIQUE,
  "user_ID"  serial  NOT NULL,
  "product_ID"  serial  NOT NULL,
  "amount_available"  integer  DEFAULT 0,
  CONSTRAINT user_product_pk PRIMARY KEY ("user_product_ID")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "user_shopping_wish" (
  "user_shopping_wish_ID"  serial  UNIQUE,
  "user_ID"  serial  NOT NULL,
  "product_ID"  serial  NOT NULL,
  "quantity"  integer  DEFAULT 0,
  "ingredient_ID"  serial  NOT NULL,
  CONSTRAINT user_shopping_wish_pk PRIMARY KEY ("user_shopping_wish_ID")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "brand_product" (
  "brand_product_ID"  serial  UNIQUE,
  "product_title"  varchar,
  "product_type_name"  varchar,
  "product_class_name"  varchar,
  "product_sub_class_name"  varchar,
  "product_minor_class_name"  varchar,
  "product_country_origin_name"  varchar,
  "product_sku_num"  integer,
  "product_long_name"  varchar,
  "product_base_UPC_num"  integer,
  "product_liters_per_container"  integer,
  "product_container_per_sell_unit"  integer,
  "product_alcohol_percent"  integer,
  "current_display_price"  integer,
  "sweetness_code"  integer,
  "ingredient_ID"  serial  NOT NULL,
  "added_by_ID"  serial  NOT NULL,
  CONSTRAINT product_pk PRIMARY KEY ("brand_product_ID")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "spirit" (
  "spirit_ID"  serial  UNIQUE,
  "product_ID"  varchar  NOT NULL,
  "distiller"  varchar,
  "presentation_notes"  varchar,
  "variety"  varchar,
  "barrel_type"  varchar,
  "age"  varchar,
  "origin"  varchar,
  "proof"  varchar,
  "tasting_notes"  varchar,
  "similar_in_profile"  varchar,
  "food_pairings"  varchar,
  CONSTRAINT spirit_pk PRIMARY KEY ("spirit_ID")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "tag" (
  "tag_ID"  serial  UNIQUE,
  "tag_label"  varchar,
  "cocktail_ID"  serial,
  CONSTRAINT tag_pk PRIMARY KEY ("tag_ID")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "team" (
  "team_ID"  serial  UNIQUE,
  "team_title"  varchar  NOT NULL  UNIQUE,
  "permissions"  varchar,
  "user_ID"  serial  NOT NULL,
  CONSTRAINT team_pk PRIMARY KEY ("team_ID")
) WITH (
  OIDS=FALSE
);


ALTER TABLE "user_cocktail" ADD CONSTRAINT "user_cocktail_fk0" FOREIGN KEY ("user_ID") REFERENCES "user"("user_ID");

ALTER TABLE "user_cocktail" ADD CONSTRAINT "user_cocktail_fk1" FOREIGN KEY ("cocktail_ID") REFERENCES "cocktail"("cocktail_ID");

ALTER TABLE "user_favorite" ADD CONSTRAINT "user_favorite_fk0" FOREIGN KEY ("user_ID") REFERENCES "user"("user_ID");

ALTER TABLE "user_favorite" ADD CONSTRAINT "user_favorite_fk1" FOREIGN KEY ("cocktail_ID") REFERENCES "cocktail"("cocktail_ID");

ALTER TABLE "user_product" ADD CONSTRAINT "user_product_fk0" FOREIGN KEY ("user_ID") REFERENCES "user"("user_ID");

ALTER TABLE "user_product" ADD CONSTRAINT "user_product_fk1" FOREIGN KEY ("product_ID") REFERENCES "product"("product_ID");

ALTER TABLE "user_shopping_wish" ADD CONSTRAINT "user_shopping_wish_fk0" FOREIGN KEY ("user_ID") REFERENCES "user"("user_ID");

ALTER TABLE "user_shopping_wish" ADD CONSTRAINT "user_shopping_wish_fk1" FOREIGN KEY ("product_ID") REFERENCES "product"("product_ID");

ALTER TABLE "user_shopping_wish" ADD CONSTRAINT "user_shopping_wish_fk2" FOREIGN KEY ("ingredient_ID") REFERENCES "ingredient"("ingredient_ID");

ALTER TABLE "cocktail" ADD CONSTRAINT "cocktail_fk0" FOREIGN KEY ("cocktail_ingredient_ID") REFERENCES "cocktail_ingredient"("ingredient_ID");

ALTER TABLE "cocktail" ADD CONSTRAINT "cocktail_fk1" FOREIGN KEY ("created_by_ID") REFERENCES "user"("user_ID");

ALTER TABLE "product" ADD CONSTRAINT "product_fk0" FOREIGN KEY ("ingredient_ID") REFERENCES "ingredient"("ingredient_ID");

ALTER TABLE "product" ADD CONSTRAINT "product_fk1" FOREIGN KEY ("added_by_ID") REFERENCES "user"("user_ID");

ALTER TABLE "cocktail_ingredient" ADD CONSTRAINT "cocktail_ingredient_fk0" FOREIGN KEY ("cocktail_ID") REFERENCES "cocktail"("cocktail_ID");

ALTER TABLE "cocktail_ingredient" ADD CONSTRAINT "cocktail_ingredient_fk1" FOREIGN KEY ("ingredient_ID") REFERENCES "ingredient"("ingredient_ID");

ALTER TABLE "tag" ADD CONSTRAINT "tag_fk0" FOREIGN KEY ("cocktail_ID") REFERENCES "cocktail"("cocktail_ID");

ALTER TABLE "team" ADD CONSTRAINT "team_fk0" FOREIGN KEY ("user_ID") REFERENCES "user"("user_ID");
