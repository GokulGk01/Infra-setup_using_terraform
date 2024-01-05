SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE health_checks;
TRUNCATE TABLE invite_users;
TRUNCATE TABLE login_tv_users;
TRUNCATE TABLE role_user;
TRUNCATE TABLE signup_users;
TRUNCATE TABLE user_devices;
TRUNCATE TABLE user_follow_studio;
TRUNCATE TABLE studios;
TRUNCATE TABLE users;
TRUNCATE TABLE studio_user;

SET FOREIGN_KEY_CHECKS = 1;


INSERT INTO users(id, username, first_name, last_name, email, password, country_code, country_iso_code, phone, dob, profile_picture, gender, google_auth_id, google_user_id, facebook_auth_id, facebook_user_id, fb_sync_id, is_fbsync, is_contact_sync, push_notification_status, email_notification_status, apple_auth_id, apple_user_id, access_otp_token, expiry_at, otp_hit_count, notification_status, is_email_verified, is_phone_verified, notify_videos, notify_newsletter, notify_email, is_active, is_archived, billing_address, billing_city, billing_state, billing_country, billing_pincode, company_name, company_address, company_city, company_state, company_country, company_pincode, company_owner_name, pancard_image, pancard_name, pancard_type, aadharcard_image, aadharcard_name, aadharcard_type, gtin_number, account_number, ifsc_code, device_limit, is_coins_credited, coins, created_at, updated_at, last_login) VALUES ('1', '4AWRBaFLNy', 'admin', null, 'vplayed@contus.in', '$2y$10$ULbI8xc2RRCXAbiohVpDbulblXBLsn.ecMjKyX1glsTSzsX10I/Xy', null, null, '7904276206', null, 'images/qzoa2v3cblob-1662557907.', 1, null, null, null, null, null, 0, 0, 1, 1, null, null, null, null, 0, 1, 0, 1, 1, 1, 1, 1, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 10, 0, 0, null, '2022-09-10 15:08:27', '2022-09-29 10:25:11');

INSERT INTO studios VALUES (1,'Vplayed','vision-view','P.O.BOX 599- 00606 Nairobi.','Chennai','Tamil Nadu','India','600005','Ndoto','vplayed@contus.in','44 4920 1000',91,'IND',NULL,NULL,NULL,NULL,NULL,'images/mctwhgbyblob-1659077097.png','We’d love to take care of your media content strategy to deliver a power-packed suite. Our in-house team, ever-evolving learning curve, and impactful infrastructure drives your platform to become a remarkable engageable and monetizable dais.',1,1,3,0,3,NULL,NULL,0,1,1,7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-10-06 14:06:18','2022-08-16 06:20:11');

INSERT INTO studio_user (id, user_id, studio_id, created_at, updated_at) VALUES (1, 1, 1, '2021-10-06 14:06:19', '2021-10-06 14:06:19');