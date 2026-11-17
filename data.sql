-- ========== PRODUITS ==========
INSERT INTO products (id, name, price_cents, stock) VALUES
-- Repas
(1,  'Salade',                        400, 20),
(2,  'Pizza',                         350, 30),
(3,  'Pastabox',                      300, 25),
(4,  'Wraps',                         300, 25),
(5,  'Sandwichs',                     250, 40),
(6,  'Nouilles',                      170, 50),
-- Boissons chaudes
(7,  'Café vanille ou noisette',       70, 100),
(8,  'Café',                           50, 150),
(9,  'Thé',                            30, 100),
-- Sodas
(10, 'Red-bull',                      150, 48),
(11, 'Coca-cola (Zéro, Cherry)',       80, 72),
(12, 'Fanta (Citron, FD)',             80, 48),
(13, 'Fuze-tea',                       80, 48),
(14, 'Oasis (Tropical, PCF)',          80, 48),
(15, 'Orangina',                       80, 48),
-- Eaux / Jus
(16, 'Eau gazeuse',                    60, 48),
(17, 'Eau (bouteille)',                50, 96),
(18, 'Caprisun',                       50, 60),
(19, 'Jus de fruit',                   40, 60),
-- Confiseries
(20, 'Kinder bueno',                   80, 40),
(21, 'Kinder bueno white',             80, 40),
(22, 'Kitkat',                         80, 40),
(23, 'Lion',                           80, 40),
(24, 'Oreo',                           80, 40),
(25, 'Twix',                           80, 40),
(26, 'Snickers',                       80, 40),
(27, 'Sucette',                        20, 100),
-- Snacks
(28, 'Barre protéiné',                100, 30),
(29, 'Gaufre chocolat',                60, 40),
(30, 'Gaufre nature',                  50, 40),
(31, 'Pom''Pote',                      50, 60),
(32, 'Chips',                          50, 60);

-- ========== MENUS (exemples inventés, le visuel n'en montre pas) ==========
INSERT INTO menus (id, name, price_cents) VALUES
                                              (1, 'Formule Pizza + soda',            400),
                                              (2, 'Formule Sandwich + Orangina + Chips', 350);

INSERT INTO menu_items (menu_id, product_id, quantity) VALUES
                                                           (1, 2,  1),   -- Pizza
                                                           (1, 11, 1),   -- Coca-cola
                                                           (2, 5,  1),   -- Sandwich
                                                           (2, 15, 1),   -- Orangina
                                                           (2, 32, 1);   -- Chips

-- ========== UTILISATEURS ==========
INSERT INTO users (id, name, admin, locked) VALUES
                                                (1, 'Admin KFET', 1, 0),
                                                (2, 'Alice Martin', 0, 0),
                                                (3, 'Bob Durand',   0, 0);

-- Remplace les hash par de vrais hash bcrypt/argon2id générés par ton appli
INSERT INTO user_auth (id, username, password_hash) VALUES
                                                        (1, 'admin', '$2b$12$REMPLACER_PAR_UN_VRAI_HASH'),
                                                        (2, 'alice', '$2b$12$REMPLACER_PAR_UN_VRAI_HASH'),
                                                        (3, 'bob',   '$2b$12$REMPLACER_PAR_UN_VRAI_HASH');

-- ========== COMMANDES D'EXEMPLE ==========
INSERT INTO orders (id, user_id, total_price_cents, status, reservation_date) VALUES
                                                                                  (1, 2, 430, 'completed', '2026-11-17 12:15:00'),
                                                                                  (2, 3, 400, 'pending',   '2026-11-18 12:30:00');

INSERT INTO order_items (order_id, product_id, quantity, unit_price_cents) VALUES
                                                                               (1, 2,  1, 350),  -- Pizza
                                                                               (1, 11, 1, 80),   -- Coca-cola
                                                                               (2, 1,  1, 400);  -- Salade

-- ========== FERMETURES ==========
INSERT INTO closings (closing_date) VALUES
                                        ('2026-12-25'),
                                        ('2027-01-01');