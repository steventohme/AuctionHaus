alter table "public"."Auction" drop constraint "Auction_bidder_id_key";

drop index if exists "public"."Auction_bidder_id_key";

alter table "public"."Auction" drop column "bidder_id";

alter table "public"."Auction" drop column "winner_id";

alter table "public"."AuctionHausUsers" drop column "status";

alter table "public"."AuctionHausUsers" add column "active" boolean not null;