SET session_replication_role = replica;
--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Ubuntu 15.1-1.pgdg20.04+1)
-- Dumped by pg_dump version 15.5 (Ubuntu 15.5-1.pgdg20.04+1)

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

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."audit_log_entries" ("instance_id", "id", "payload", "created_at", "ip_address") VALUES
	('00000000-0000-0000-0000-000000000000', '399ded17-fe47-4735-9a2a-e6107e6eff9f', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"admin@example.com","user_id":"e1bbe910-e02e-4bd8-9716-d4fd28a4e9f4","user_phone":""}}', '2023-12-15 20:52:21.674753+00', ''),
	('00000000-0000-0000-0000-000000000000', '7cd5058e-f114-4467-a8cf-96b91f626eb7', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"admin@example.com","user_id":"e1bbe910-e02e-4bd8-9716-d4fd28a4e9f4","user_phone":""}}', '2023-12-15 20:52:53.711424+00', ''),
	('00000000-0000-0000-0000-000000000000', '88363880-f52c-4f02-a1ba-e59c21e6d1ca', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"steventohme59@gmail.com","user_id":"441a78a5-5e6d-4699-91f3-0dd43189d964","user_phone":""}}', '2023-12-16 01:03:30.406227+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e1b204b0-ea4c-4cb0-88b5-bf7d902a989b', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"admin@example.ca","user_id":"d3df9130-6ee8-44d1-bdfb-6b21169e6366","user_phone":""}}', '2023-12-28 02:38:49.12256+00', '');


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at") VALUES
	('00000000-0000-0000-0000-000000000000', '441a78a5-5e6d-4699-91f3-0dd43189d964', 'authenticated', 'authenticated', 'steventohme59@gmail.com', '$2a$10$6rPTpDf5W2io2r5hO9Ru1uEZ8/8e4RRY7K1wQZVpgg4q5qvxIpX8S', '2023-12-16 01:03:30.407583+00', NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{}', NULL, '2023-12-16 01:03:30.4042+00', '2023-12-16 01:03:30.407787+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL),
	('00000000-0000-0000-0000-000000000000', 'd3df9130-6ee8-44d1-bdfb-6b21169e6366', 'authenticated', 'authenticated', 'admin@example.ca', '$2a$10$ehGl.E/H0K042Y3f/tTrh.RcyIC8IGr/zoH9tadKj488GU4mGcfum', '2023-12-28 02:38:49.124796+00', NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{}', NULL, '2023-12-28 02:38:49.114274+00', '2023-12-28 02:38:49.125025+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL);


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES
	('441a78a5-5e6d-4699-91f3-0dd43189d964', '441a78a5-5e6d-4699-91f3-0dd43189d964', '{"sub": "441a78a5-5e6d-4699-91f3-0dd43189d964", "email": "steventohme59@gmail.com", "email_verified": false, "phone_verified": false}', 'email', '2023-12-16 01:03:30.405179+00', '2023-12-16 01:03:30.405229+00', '2023-12-16 01:03:30.405229+00', 'b1f834ee-956c-48f3-b59e-fba3341f8d4a'),
	('d3df9130-6ee8-44d1-bdfb-6b21169e6366', 'd3df9130-6ee8-44d1-bdfb-6b21169e6366', '{"sub": "d3df9130-6ee8-44d1-bdfb-6b21169e6366", "email": "admin@example.ca", "email_verified": false, "phone_verified": false}', 'email', '2023-12-28 02:38:49.121327+00', '2023-12-28 02:38:49.121403+00', '2023-12-28 02:38:49.121403+00', 'd8235e89-2a6d-4e03-b8d4-c6cb38ffc2d2');


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: key; Type: TABLE DATA; Schema: pgsodium; Owner: supabase_admin
--



--
-- Data for Name: AuctionHausUsers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."AuctionHausUsers" ("username", "buyer_rating", "seller_rating", "seller_reviews", "buyer_reviews", "profile_picture", "bio", "Inactive_since", "updated_at", "deleted_at", "id", "active") VALUES
	('steven', 5, 5, 5, 5, NULL, NULL, NULL, NULL, NULL, '441a78a5-5e6d-4699-91f3-0dd43189d964', true);


--
-- Data for Name: Auction; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: AuctionBidders; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: AuctionWinners; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Bid; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Notification; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Review; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: UserAddress; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--



--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 1, false);


--
-- Name: key_key_id_seq; Type: SEQUENCE SET; Schema: pgsodium; Owner: supabase_admin
--

SELECT pg_catalog.setval('"pgsodium"."key_key_id_seq"', 1, false);


--
-- Name: Review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."Review_id_seq"', 1, false);


--
-- Name: UserAddress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."UserAddress_id_seq"', 1, false);


--
-- PostgreSQL database dump complete
--

RESET ALL;
