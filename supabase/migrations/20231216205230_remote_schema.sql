
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE EXTENSION IF NOT EXISTS "pgsodium" WITH SCHEMA "pgsodium";

ALTER SCHEMA "public" OWNER TO "postgres";

CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";

CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";

CREATE TYPE "public"."auction_types" AS ENUM (
    'Early Bird',
    'Auctioneers Choice',
    'Budget Battle'
);

ALTER TYPE "public"."auction_types" OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";

CREATE TABLE IF NOT EXISTS "public"."Auction" (
    "name" "text" NOT NULL,
    "image" "text",
    "description" "text",
    "starting_price" double precision NOT NULL,
    "current_price" double precision NOT NULL,
    "grab_now_price" double precision,
    "auction_type" "public"."auction_types" NOT NULL,
    "start_time" timestamp with time zone DEFAULT "now"() NOT NULL,
    "end_time" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "deleted_at" timestamp with time zone,
    "winner_id" integer,
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "bidder_id" "uuid" NOT NULL,
    "auctioneer_id" "uuid" NOT NULL,
    "active" boolean NOT NULL
);

ALTER TABLE "public"."Auction" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."AuctionHausUsers" (
    "username" "text" NOT NULL,
    "buyer_rating" double precision DEFAULT 0.0 NOT NULL,
    "seller_rating" double precision DEFAULT 0.0 NOT NULL,
    "seller_reviews" integer DEFAULT 0 NOT NULL,
    "buyer_reviews" integer DEFAULT 0 NOT NULL,
    "profile_picture" "text",
    "bio" "text",
    "status" "text" DEFAULT 'offline'::"text",
    "Inactive_since" timestamp(3) without time zone,
    "updated_at" timestamp(3) without time zone,
    "deleted_at" timestamp(3) without time zone,
    "id" "uuid" NOT NULL
);

ALTER TABLE "public"."AuctionHausUsers" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."Bid" (
    "id" integer NOT NULL,
    "bid_amount" double precision NOT NULL,
    "created_at" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "status" "text" DEFAULT 'pending'::"text" NOT NULL,
    "auction_id" "uuid" NOT NULL,
    "bidder_id" "uuid" NOT NULL
);

ALTER TABLE "public"."Bid" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."Bid_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."Bid_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."Bid_id_seq" OWNED BY "public"."Bid"."id";

CREATE TABLE IF NOT EXISTS "public"."UserAddress" (
    "id" integer NOT NULL,
    "address_line1" "text" NOT NULL,
    "address_line2" "text",
    "city" "text" NOT NULL,
    "state_or_province" "text" NOT NULL,
    "postal_code" "text" NOT NULL,
    "country" "text" NOT NULL,
    "created_at" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" timestamp(3) without time zone NOT NULL,
    "deleted_at" timestamp(3) without time zone,
    "user_id" "uuid" NOT NULL
);

ALTER TABLE "public"."UserAddress" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."UserAddress_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."UserAddress_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."UserAddress_id_seq" OWNED BY "public"."UserAddress"."id";

ALTER TABLE ONLY "public"."Bid" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."Bid_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."UserAddress" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."UserAddress_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."AuctionHausUsers"
    ADD CONSTRAINT "AuctionHausUsers_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."AuctionHausUsers"
    ADD CONSTRAINT "AuctionHausUsers_proper_id_key" UNIQUE ("id");

ALTER TABLE ONLY "public"."Auction"
    ADD CONSTRAINT "Auction_bidder_id_key" UNIQUE ("bidder_id");

ALTER TABLE ONLY "public"."Auction"
    ADD CONSTRAINT "Auction_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."Auction"
    ADD CONSTRAINT "Auction_proper_id_key" UNIQUE ("id");

ALTER TABLE ONLY "public"."Bid"
    ADD CONSTRAINT "Bid_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."UserAddress"
    ADD CONSTRAINT "UserAddress_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."UserAddress"
    ADD CONSTRAINT "UserAddress_user_id_key" UNIQUE ("user_id");

CREATE UNIQUE INDEX "AuctionHausUsers_username_idx" ON "public"."AuctionHausUsers" USING "btree" ("username");

CREATE UNIQUE INDEX "Bid_id_key" ON "public"."Bid" USING "btree" ("id");

CREATE UNIQUE INDEX "UserAddress_id_key" ON "public"."UserAddress" USING "btree" ("id");

ALTER TABLE ONLY "public"."AuctionHausUsers"
    ADD CONSTRAINT "AuctionHausUsers_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."Auction"
    ADD CONSTRAINT "Auction_auctioneer_id_fkey" FOREIGN KEY ("auctioneer_id") REFERENCES "public"."AuctionHausUsers"("id");

ALTER TABLE ONLY "public"."Bid"
    ADD CONSTRAINT "Bid_auction_id_fkey" FOREIGN KEY ("auction_id") REFERENCES "public"."Auction"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."Bid"
    ADD CONSTRAINT "Bid_bidder_id_fkey" FOREIGN KEY ("bidder_id") REFERENCES "public"."AuctionHausUsers"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."UserAddress"
    ADD CONSTRAINT "UserAddress_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."AuctionHausUsers"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "public"."AuctionHausUsers" ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable insert for authenticated users only" ON "public"."AuctionHausUsers" FOR INSERT TO "authenticated" WITH CHECK (true);

CREATE POLICY "Enable insert for users based on user_id" ON "public"."AuctionHausUsers" FOR INSERT WITH CHECK (true);

CREATE POLICY "Enable read access for all users" ON "public"."AuctionHausUsers" FOR SELECT USING (true);

CREATE POLICY "REMOVE FOR PRODUCTION" ON "public"."AuctionHausUsers";

REVOKE USAGE ON SCHEMA "public" FROM PUBLIC;

RESET ALL;
