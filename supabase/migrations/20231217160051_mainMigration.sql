create type "public"."auction_types" as enum ('Early Bird', 'Auctioneers Choice', 'Budget Battle');

create sequence "public"."Bid_id_seq";

create sequence "public"."UserAddress_id_seq";

create table "public"."Auction" (
    "name" text not null,
    "image" text,
    "description" text,
    "starting_price" double precision not null,
    "current_price" double precision not null,
    "grab_now_price" double precision,
    "auction_type" auction_types not null,
    "start_time" timestamp with time zone not null default now(),
    "end_time" timestamp with time zone,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now(),
    "deleted_at" timestamp with time zone,
    "winner_id" integer,
    "id" uuid not null default gen_random_uuid(),
    "bidder_id" uuid not null,
    "auctioneer_id" uuid not null,
    "active" boolean not null
);


create table "public"."AuctionBidders" (
    "bidder_id" uuid not null,
    "auction_id" uuid not null
);


alter table "public"."AuctionBidders" enable row level security;

create table "public"."AuctionHausUsers" (
    "username" text not null,
    "buyer_rating" double precision not null default 0.0,
    "seller_rating" double precision not null default 0.0,
    "seller_reviews" integer not null default 0,
    "buyer_reviews" integer not null default 0,
    "profile_picture" text,
    "bio" text,
    "status" text default 'offline'::text,
    "Inactive_since" timestamp(3) without time zone,
    "updated_at" timestamp(3) without time zone,
    "deleted_at" timestamp(3) without time zone,
    "id" uuid not null
);


alter table "public"."AuctionHausUsers" enable row level security;

create table "public"."AuctionWinners" (
    "winner_id" uuid not null,
    "auction_id" uuid not null
);


alter table "public"."AuctionWinners" enable row level security;

create table "public"."Bid" (
    "id" integer not null default nextval('"Bid_id_seq"'::regclass),
    "bid_amount" double precision not null,
    "created_at" timestamp(3) without time zone not null default CURRENT_TIMESTAMP,
    "status" text not null default 'pending'::text,
    "auction_id" uuid not null,
    "bidder_id" uuid not null
);


create table "public"."UserAddress" (
    "id" integer not null default nextval('"UserAddress_id_seq"'::regclass),
    "address_line1" text not null,
    "address_line2" text,
    "city" text not null,
    "state_or_province" text not null,
    "postal_code" text not null,
    "country" text not null,
    "created_at" timestamp(3) without time zone not null default CURRENT_TIMESTAMP,
    "updated_at" timestamp(3) without time zone not null,
    "deleted_at" timestamp(3) without time zone,
    "user_id" uuid not null
);


alter sequence "public"."Bid_id_seq" owned by "public"."Bid"."id";

alter sequence "public"."UserAddress_id_seq" owned by "public"."UserAddress"."id";

CREATE UNIQUE INDEX "AuctionBidders_pkey" ON public."AuctionBidders" USING btree (bidder_id, auction_id);

CREATE UNIQUE INDEX "AuctionHausUsers_pkey" ON public."AuctionHausUsers" USING btree (id);

CREATE UNIQUE INDEX "AuctionHausUsers_proper_id_key" ON public."AuctionHausUsers" USING btree (id);

CREATE UNIQUE INDEX "AuctionHausUsers_username_idx" ON public."AuctionHausUsers" USING btree (username);

CREATE UNIQUE INDEX "AuctionWinners_pkey" ON public."AuctionWinners" USING btree (winner_id, auction_id);

CREATE UNIQUE INDEX "Auction_bidder_id_key" ON public."Auction" USING btree (bidder_id);

CREATE UNIQUE INDEX "Auction_pkey" ON public."Auction" USING btree (id);

CREATE UNIQUE INDEX "Auction_proper_id_key" ON public."Auction" USING btree (id);

CREATE UNIQUE INDEX "Bid_id_key" ON public."Bid" USING btree (id);

CREATE UNIQUE INDEX "Bid_pkey" ON public."Bid" USING btree (id);

CREATE UNIQUE INDEX "UserAddress_id_key" ON public."UserAddress" USING btree (id);

CREATE UNIQUE INDEX "UserAddress_pkey" ON public."UserAddress" USING btree (id);

CREATE UNIQUE INDEX "UserAddress_user_id_key" ON public."UserAddress" USING btree (user_id);

alter table "public"."Auction" add constraint "Auction_pkey" PRIMARY KEY using index "Auction_pkey";

alter table "public"."AuctionBidders" add constraint "AuctionBidders_pkey" PRIMARY KEY using index "AuctionBidders_pkey";

alter table "public"."AuctionHausUsers" add constraint "AuctionHausUsers_pkey" PRIMARY KEY using index "AuctionHausUsers_pkey";

alter table "public"."AuctionWinners" add constraint "AuctionWinners_pkey" PRIMARY KEY using index "AuctionWinners_pkey";

alter table "public"."Bid" add constraint "Bid_pkey" PRIMARY KEY using index "Bid_pkey";

alter table "public"."UserAddress" add constraint "UserAddress_pkey" PRIMARY KEY using index "UserAddress_pkey";

alter table "public"."Auction" add constraint "Auction_auctioneer_id_fkey" FOREIGN KEY (auctioneer_id) REFERENCES "AuctionHausUsers"(id) not valid;

alter table "public"."Auction" validate constraint "Auction_auctioneer_id_fkey";

alter table "public"."Auction" add constraint "Auction_bidder_id_key" UNIQUE using index "Auction_bidder_id_key";

alter table "public"."Auction" add constraint "Auction_proper_id_key" UNIQUE using index "Auction_proper_id_key";

alter table "public"."AuctionBidders" add constraint "AuctionBidders_auction_id_fkey" FOREIGN KEY (auction_id) REFERENCES "Auction"(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."AuctionBidders" validate constraint "AuctionBidders_auction_id_fkey";

alter table "public"."AuctionBidders" add constraint "AuctionBidders_bidder_id_fkey" FOREIGN KEY (bidder_id) REFERENCES "AuctionHausUsers"(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."AuctionBidders" validate constraint "AuctionBidders_bidder_id_fkey";

alter table "public"."AuctionHausUsers" add constraint "AuctionHausUsers_id_fkey" FOREIGN KEY (id) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."AuctionHausUsers" validate constraint "AuctionHausUsers_id_fkey";

alter table "public"."AuctionHausUsers" add constraint "AuctionHausUsers_proper_id_key" UNIQUE using index "AuctionHausUsers_proper_id_key";

alter table "public"."AuctionWinners" add constraint "AuctionWinners_auction_id_fkey" FOREIGN KEY (auction_id) REFERENCES "Auction"(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."AuctionWinners" validate constraint "AuctionWinners_auction_id_fkey";

alter table "public"."AuctionWinners" add constraint "AuctionWinners_winner_id_fkey" FOREIGN KEY (winner_id) REFERENCES "AuctionHausUsers"(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."AuctionWinners" validate constraint "AuctionWinners_winner_id_fkey";

alter table "public"."Bid" add constraint "Bid_auction_id_fkey" FOREIGN KEY (auction_id) REFERENCES "Auction"(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."Bid" validate constraint "Bid_auction_id_fkey";

alter table "public"."Bid" add constraint "Bid_bidder_id_fkey" FOREIGN KEY (bidder_id) REFERENCES "AuctionHausUsers"(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."Bid" validate constraint "Bid_bidder_id_fkey";

alter table "public"."UserAddress" add constraint "UserAddress_user_id_fkey" FOREIGN KEY (user_id) REFERENCES "AuctionHausUsers"(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."UserAddress" validate constraint "UserAddress_user_id_fkey";

alter table "public"."UserAddress" add constraint "UserAddress_user_id_key" UNIQUE using index "UserAddress_user_id_key";

grant delete on table "public"."Auction" to "anon";

grant insert on table "public"."Auction" to "anon";

grant references on table "public"."Auction" to "anon";

grant select on table "public"."Auction" to "anon";

grant trigger on table "public"."Auction" to "anon";

grant truncate on table "public"."Auction" to "anon";

grant update on table "public"."Auction" to "anon";

grant delete on table "public"."Auction" to "authenticated";

grant insert on table "public"."Auction" to "authenticated";

grant references on table "public"."Auction" to "authenticated";

grant select on table "public"."Auction" to "authenticated";

grant trigger on table "public"."Auction" to "authenticated";

grant truncate on table "public"."Auction" to "authenticated";

grant update on table "public"."Auction" to "authenticated";

grant delete on table "public"."Auction" to "service_role";

grant insert on table "public"."Auction" to "service_role";

grant references on table "public"."Auction" to "service_role";

grant select on table "public"."Auction" to "service_role";

grant trigger on table "public"."Auction" to "service_role";

grant truncate on table "public"."Auction" to "service_role";

grant update on table "public"."Auction" to "service_role";

grant delete on table "public"."AuctionBidders" to "anon";

grant insert on table "public"."AuctionBidders" to "anon";

grant references on table "public"."AuctionBidders" to "anon";

grant select on table "public"."AuctionBidders" to "anon";

grant trigger on table "public"."AuctionBidders" to "anon";

grant truncate on table "public"."AuctionBidders" to "anon";

grant update on table "public"."AuctionBidders" to "anon";

grant delete on table "public"."AuctionBidders" to "authenticated";

grant insert on table "public"."AuctionBidders" to "authenticated";

grant references on table "public"."AuctionBidders" to "authenticated";

grant select on table "public"."AuctionBidders" to "authenticated";

grant trigger on table "public"."AuctionBidders" to "authenticated";

grant truncate on table "public"."AuctionBidders" to "authenticated";

grant update on table "public"."AuctionBidders" to "authenticated";

grant delete on table "public"."AuctionBidders" to "service_role";

grant insert on table "public"."AuctionBidders" to "service_role";

grant references on table "public"."AuctionBidders" to "service_role";

grant select on table "public"."AuctionBidders" to "service_role";

grant trigger on table "public"."AuctionBidders" to "service_role";

grant truncate on table "public"."AuctionBidders" to "service_role";

grant update on table "public"."AuctionBidders" to "service_role";

grant delete on table "public"."AuctionHausUsers" to "anon";

grant insert on table "public"."AuctionHausUsers" to "anon";

grant references on table "public"."AuctionHausUsers" to "anon";

grant select on table "public"."AuctionHausUsers" to "anon";

grant trigger on table "public"."AuctionHausUsers" to "anon";

grant truncate on table "public"."AuctionHausUsers" to "anon";

grant update on table "public"."AuctionHausUsers" to "anon";

grant delete on table "public"."AuctionHausUsers" to "authenticated";

grant insert on table "public"."AuctionHausUsers" to "authenticated";

grant references on table "public"."AuctionHausUsers" to "authenticated";

grant select on table "public"."AuctionHausUsers" to "authenticated";

grant trigger on table "public"."AuctionHausUsers" to "authenticated";

grant truncate on table "public"."AuctionHausUsers" to "authenticated";

grant update on table "public"."AuctionHausUsers" to "authenticated";

grant delete on table "public"."AuctionHausUsers" to "service_role";

grant insert on table "public"."AuctionHausUsers" to "service_role";

grant references on table "public"."AuctionHausUsers" to "service_role";

grant select on table "public"."AuctionHausUsers" to "service_role";

grant trigger on table "public"."AuctionHausUsers" to "service_role";

grant truncate on table "public"."AuctionHausUsers" to "service_role";

grant update on table "public"."AuctionHausUsers" to "service_role";

grant delete on table "public"."AuctionWinners" to "anon";

grant insert on table "public"."AuctionWinners" to "anon";

grant references on table "public"."AuctionWinners" to "anon";

grant select on table "public"."AuctionWinners" to "anon";

grant trigger on table "public"."AuctionWinners" to "anon";

grant truncate on table "public"."AuctionWinners" to "anon";

grant update on table "public"."AuctionWinners" to "anon";

grant delete on table "public"."AuctionWinners" to "authenticated";

grant insert on table "public"."AuctionWinners" to "authenticated";

grant references on table "public"."AuctionWinners" to "authenticated";

grant select on table "public"."AuctionWinners" to "authenticated";

grant trigger on table "public"."AuctionWinners" to "authenticated";

grant truncate on table "public"."AuctionWinners" to "authenticated";

grant update on table "public"."AuctionWinners" to "authenticated";

grant delete on table "public"."AuctionWinners" to "service_role";

grant insert on table "public"."AuctionWinners" to "service_role";

grant references on table "public"."AuctionWinners" to "service_role";

grant select on table "public"."AuctionWinners" to "service_role";

grant trigger on table "public"."AuctionWinners" to "service_role";

grant truncate on table "public"."AuctionWinners" to "service_role";

grant update on table "public"."AuctionWinners" to "service_role";

grant delete on table "public"."Bid" to "anon";

grant insert on table "public"."Bid" to "anon";

grant references on table "public"."Bid" to "anon";

grant select on table "public"."Bid" to "anon";

grant trigger on table "public"."Bid" to "anon";

grant truncate on table "public"."Bid" to "anon";

grant update on table "public"."Bid" to "anon";

grant delete on table "public"."Bid" to "authenticated";

grant insert on table "public"."Bid" to "authenticated";

grant references on table "public"."Bid" to "authenticated";

grant select on table "public"."Bid" to "authenticated";

grant trigger on table "public"."Bid" to "authenticated";

grant truncate on table "public"."Bid" to "authenticated";

grant update on table "public"."Bid" to "authenticated";

grant delete on table "public"."Bid" to "service_role";

grant insert on table "public"."Bid" to "service_role";

grant references on table "public"."Bid" to "service_role";

grant select on table "public"."Bid" to "service_role";

grant trigger on table "public"."Bid" to "service_role";

grant truncate on table "public"."Bid" to "service_role";

grant update on table "public"."Bid" to "service_role";

grant delete on table "public"."UserAddress" to "anon";

grant insert on table "public"."UserAddress" to "anon";

grant references on table "public"."UserAddress" to "anon";

grant select on table "public"."UserAddress" to "anon";

grant trigger on table "public"."UserAddress" to "anon";

grant truncate on table "public"."UserAddress" to "anon";

grant update on table "public"."UserAddress" to "anon";

grant delete on table "public"."UserAddress" to "authenticated";

grant insert on table "public"."UserAddress" to "authenticated";

grant references on table "public"."UserAddress" to "authenticated";

grant select on table "public"."UserAddress" to "authenticated";

grant trigger on table "public"."UserAddress" to "authenticated";

grant truncate on table "public"."UserAddress" to "authenticated";

grant update on table "public"."UserAddress" to "authenticated";

grant delete on table "public"."UserAddress" to "service_role";

grant insert on table "public"."UserAddress" to "service_role";

grant references on table "public"."UserAddress" to "service_role";

grant select on table "public"."UserAddress" to "service_role";

grant trigger on table "public"."UserAddress" to "service_role";

grant truncate on table "public"."UserAddress" to "service_role";

grant update on table "public"."UserAddress" to "service_role";

create policy "Enable insert for authenticated users only"
on "public"."AuctionHausUsers"
as permissive
for insert
to authenticated
with check (true);


create policy "Enable insert for users based on user_id"
on "public"."AuctionHausUsers"
as permissive
for insert
to public
with check (true);


create policy "Enable read access for all users"
on "public"."AuctionHausUsers"
as permissive
for select
to public
using (true);


create policy "REMOVE FOR PRODUCTION"
on "public"."AuctionHausUsers"
as permissive
for all
to public;
