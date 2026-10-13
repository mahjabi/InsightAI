// ==============================================================================
// CS 5542 Challenge 3: InsightAI Knowledge Graph Construction Script
// Platform: Neo4j AuraDB / Neo4j Desktop
// Domain: E-Commerce Multi-Hop Logistics & Customer Review Intelligence
// ==============================================================================

// ------------------------------------------------------------------------------
// Step 1: Schema Constraints & Indexes (Ensures Entity Uniqueness & Rapid Traversal)
// ------------------------------------------------------------------------------
CREATE CONSTRAINT IF NOT EXISTS FOR (c:Customer) REQUIRE c.customer_id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (s:Seller) REQUIRE s.seller_id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (o:Order) REQUIRE o.order_id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (p:Product) REQUIRE p.product_id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (r:Review) REQUIRE r.review_id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (route:LogisticsRoute) REQUIRE route.route_id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (cause:ComplaintCause) REQUIRE cause.name IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (act:RemediationAction) REQUIRE act.action_type IS UNIQUE;

// ------------------------------------------------------------------------------
// Step 2: Clear Existing Graph (Optional: Uncomment if refreshing database)
// ------------------------------------------------------------------------------
// MATCH (n) DETACH DELETE n;

// ------------------------------------------------------------------------------
// Step 3: Create Geographic Logistics Routes
// ------------------------------------------------------------------------------
MERGE (r1:LogisticsRoute {route_id: 'SP_TO_RJ', origin_state: 'SP', destination_state: 'RJ', avg_transit_days: 22.4, congestion_tier: 'HIGH'})
MERGE (r2:LogisticsRoute {route_id: 'SP_TO_BA', origin_state: 'SP', destination_state: 'BA', avg_transit_days: 28.5, congestion_tier: 'CRITICAL'})
MERGE (r3:LogisticsRoute {route_id: 'SP_TO_MG', origin_state: 'SP', destination_state: 'MG', avg_transit_days: 12.1, congestion_tier: 'MODERATE'})
MERGE (r4:LogisticsRoute {route_id: 'PR_TO_SP', origin_state: 'PR', destination_state: 'SP', avg_transit_days: 8.4, congestion_tier: 'LOW'});

// ------------------------------------------------------------------------------
// Step 4: Create Root-Cause Complaint Nodes & Operational Remediation Actions
// ------------------------------------------------------------------------------
MERGE (cause1:ComplaintCause {name: 'damaged_product', category: 'Physical Quality', severity: 'HIGH'})
MERGE (cause2:ComplaintCause {name: 'delivery_delay', category: 'Logistics SLA', severity: 'HIGH'})
MERGE (cause3:ComplaintCause {name: 'missing_parts', category: 'Packaging/Fulfillment', severity: 'MEDIUM'})
MERGE (cause4:ComplaintCause {name: 'poor_quality', category: 'Product Spec', severity: 'MEDIUM'})
MERGE (cause5:ComplaintCause {name: 'wrong_item', category: 'Fulfillment Error', severity: 'HIGH'});

MERGE (act1:RemediationAction {action_type: 'Mandate_Reinforced_Packaging_Heavy_Items', target_dept: 'Logistics/Seller Ops', status: 'Active'})
MERGE (act2:RemediationAction {action_type: 'Carrier_Contract_Renegotiation_SLA', target_dept: 'Carrier Procurement', status: 'Active'})
MERGE (act3:RemediationAction {action_type: 'Buffer_Estimated_Delivery_Days_Plus_5', target_dept: 'Checkout Experience', status: 'Active'})
MERGE (act4:RemediationAction {action_type: 'Seller_Quality_Audit_Inspection', target_dept: 'Merchant Compliance', status: 'Active'});

MERGE (cause1)-[:TRIGGERS_REMEDY]->(act1)
MERGE (cause2)-[:TRIGGERS_REMEDY]->(act2)
MERGE (cause2)-[:TRIGGERS_REMEDY]->(act3)
MERGE (cause3)-[:TRIGGERS_REMEDY]->(act4);

// ------------------------------------------------------------------------------
// Step 5: Create Product Entities (Varying Weights, Dimensions & Categories)
// ------------------------------------------------------------------------------
MERGE (p1:Product {product_id: 'PROD_1001', category: 'furniture_decor', weight_g: 4800, length_cm: 90, height_cm: 75, width_cm: 60, is_fragile: true})
MERGE (p2:Product {product_id: 'PROD_1002', category: 'furniture_decor', weight_g: 12500, length_cm: 120, height_cm: 80, width_cm: 70, is_fragile: true})
MERGE (p3:Product {product_id: 'PROD_1003', category: 'bed_bath_table', weight_g: 1100, length_cm: 35, height_cm: 15, width_cm: 25, is_fragile: false})
MERGE (p4:Product {product_id: 'PROD_1004', category: 'computers_accessories', weight_g: 650, length_cm: 20, height_cm: 5, width_cm: 15, is_fragile: false})
MERGE (p5:Product {product_id: 'PROD_1005', category: 'health_beauty', weight_g: 350, length_cm: 18, height_cm: 10, width_cm: 10, is_fragile: false})
MERGE (p6:Product {product_id: 'PROD_1006', category: 'sports_leisure', weight_g: 2200, length_cm: 50, height_cm: 25, width_cm: 30, is_fragile: false});

// ------------------------------------------------------------------------------
// Step 6: Create Sellers & Fulfillment Hubs
// ------------------------------------------------------------------------------
MERGE (s1:Seller {seller_id: 'SELLER_182', city: 'Sao Paulo', state: 'SP', compliance_rating: 3.2, total_fulfilled_orders: 450})
MERGE (s2:Seller {seller_id: 'SELLER_205', city: 'Curitiba', state: 'PR', compliance_rating: 4.8, total_fulfilled_orders: 820})
MERGE (s3:Seller {seller_id: 'SELLER_114', city: 'Campinas', state: 'SP', compliance_rating: 3.9, total_fulfilled_orders: 310});

MERGE (s1)-[:FULFILLS_PRODUCT]->(p1)
MERGE (s1)-[:FULFILLS_PRODUCT]->(p2)
MERGE (s2)-[:FULFILLS_PRODUCT]->(p4)
MERGE (s3)-[:FULFILLS_PRODUCT]->(p3)
MERGE (s3)-[:FULFILLS_PRODUCT]->(p5);

// ------------------------------------------------------------------------------
// Step 7: Create Customers
// ------------------------------------------------------------------------------
MERGE (c1:Customer {customer_id: 'CUST_4821', city: 'Rio de Janeiro', state: 'RJ', lifetime_orders: 2})
MERGE (c2:Customer {customer_id: 'CUST_5190', city: 'Salvador', state: 'BA', lifetime_orders: 1})
MERGE (c3:Customer {customer_id: 'CUST_3304', city: 'Belo Horizonte', state: 'MG', lifetime_orders: 4})
MERGE (c4:Customer {customer_id: 'CUST_1088', city: 'Sao Paulo', state: 'SP', lifetime_orders: 6})
MERGE (c5:Customer {customer_id: 'CUST_7721', city: 'Niteroi', state: 'RJ', lifetime_orders: 1});

// ------------------------------------------------------------------------------
// Step 8: Create Orders & Transactional Multi-Hop Relationships
// ------------------------------------------------------------------------------
// Order 1: Heavy furniture with 25 days transit on congested route -> Damaged Product
MERGE (o1:Order {order_id: 'ORD_50042', purchase_date: '2017-08-10', delivered_date: '2017-09-04', actual_delivery_days: 25, estimated_days: 14, is_delayed: 1, freight_value: 48.50})
MERGE (c1)-[:PLACED_ORDER]->(o1)
MERGE (o1)-[:CONTAINS_ITEM]->(p1)
MERGE (o1)-[:FULFILLED_BY]->(s1)
MERGE (o1)-[:TRANSPORTED_VIA]->(r1)

// Order 2: Extra-heavy sofa to Bahia -> Delayed & Damaged
MERGE (o2:Order {order_id: 'ORD_50090', purchase_date: '2017-09-01', delivered_date: '2017-10-02', actual_delivery_days: 31, estimated_days: 16, is_delayed: 1, freight_value: 82.10})
MERGE (c2)-[:PLACED_ORDER]->(o2)
MERGE (o2)-[:CONTAINS_ITEM]->(p2)
MERGE (o2)-[:FULFILLED_BY]->(s1)
MERGE (o2)-[:TRANSPORTED_VIA]->(r2)

// Order 3: Bed Bath Table -> Delayed Delivery & Poor Stitching
MERGE (o3:Order {order_id: 'ORD_50119', purchase_date: '2017-10-12', delivered_date: '2017-10-31', actual_delivery_days: 19, estimated_days: 14, is_delayed: 1, freight_value: 22.00})
MERGE (c3)-[:PLACED_ORDER]->(o3)
MERGE (o3)-[:CONTAINS_ITEM]->(p3)
MERGE (o3)-[:FULFILLED_BY]->(s3)
MERGE (o3)-[:TRANSPORTED_VIA]->(r3)

// Order 4: Computer Keyboard -> Delivered in 4 days, Excellent Experience
MERGE (o4:Order {order_id: 'ORD_50220', purchase_date: '2017-11-05', delivered_date: '2017-11-09', actual_delivery_days: 4, estimated_days: 12, is_delayed: 0, freight_value: 14.80})
MERGE (c4)-[:PLACED_ORDER]->(o4)
MERGE (o4)-[:CONTAINS_ITEM]->(p4)
MERGE (o4)-[:FULFILLED_BY]->(s2)
MERGE (o4)-[:TRANSPORTED_VIA]->(r4)

// Order 5: Furniture to RJ -> Arrived on-time but missing assembly screws
MERGE (o5:Order {order_id: 'ORD_50335', purchase_date: '2017-11-15', delivered_date: '2017-11-21', actual_delivery_days: 6, estimated_days: 14, is_delayed: 0, freight_value: 28.50})
MERGE (c5)-[:PLACED_ORDER]->(o5)
MERGE (o5)-[:CONTAINS_ITEM]->(p1)
MERGE (o5)-[:FULFILLED_BY]->(s1)
MERGE (o5)-[:TRANSPORTED_VIA]->(r1)

// ------------------------------------------------------------------------------
// Step 9: Create Reviews & Qualitative Grounding Links
// ------------------------------------------------------------------------------
MERGE (rev1:Review {review_id: 'REV_90090', score: 1, message_en: 'Table arrived with broken legs and deep scratches.', message_pt: 'Mesa chegou com perna quebrada e arranhoes profundos.'})
MERGE (rev2:Review {review_id: 'REV_90074', score: 1, message_en: 'Over 30 days delivery delay and wood was completely cracked.', message_pt: 'Atraso de mais de 30 dias e a madeira veio toda rachada.'})
MERGE (rev3:Review {review_id: 'REV_90279', score: 2, message_en: 'Bedsheet tore on first wash and delivery was 5 days late.', message_pt: 'O lencol rasgou na primeira lavagem e entrega atrasou.'})
MERGE (rev4:Review {review_id: 'REV_90401', score: 5, message_en: 'Ultra-fast delivery in 4 days! Keyboard is genuine and pristine.', message_pt: 'Entrega ultra rapida em 4 dias! Teclado original e perfeito.'})
MERGE (rev5:Review {review_id: 'REV_90512', score: 1, message_en: 'Missing essential screws to assemble the bookcase.', message_pt: 'Faltaram parafusos essenciais para a montagem da estante.'})

MERGE (o1)-[:RECEIVES_FEEDBACK]->(rev1)
MERGE (o2)-[:RECEIVES_FEEDBACK]->(rev2)
MERGE (o3)-[:RECEIVES_FEEDBACK]->(rev3)
MERGE (o4)-[:RECEIVES_FEEDBACK]->(rev4)
MERGE (o5)-[:RECEIVES_FEEDBACK]->(rev5)

MERGE (rev1)-[:CITES_COMPLAINT]->(cause1)
MERGE (rev2)-[:CITES_COMPLAINT]->(cause1)
MERGE (rev2)-[:CITES_COMPLAINT]->(cause2)
MERGE (rev3)-[:CITES_COMPLAINT]->(cause2)
MERGE (rev3)-[:CITES_COMPLAINT]->(cause4)
MERGE (rev5)-[:CITES_COMPLAINT]->(cause3);

// Connect Routes with empirical delay correlations
MERGE (r1)-[:EXPERIENCES_DELAY_ON {delay_count: 38}]->(cause2)
MERGE (r2)-[:EXPERIENCES_DELAY_ON {delay_count: 54}]->(cause2)
MERGE (r1)-[:EXPERIENCES_DAMAGE_ON {damage_count: 29}]->(cause1)
MERGE (r2)-[:EXPERIENCES_DAMAGE_ON {damage_count: 41}]->(cause1);
