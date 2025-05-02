# E-Commerce Inventory & Order Management System

A comprehensive SQL-based solution for managing inventory, processing orders, and generating business insights for an e-commerce business.

## Project Overview

This system provides a complete database solution to handle:
- Product inventory tracking
- Customer information management
- Order processing and fulfillment
- Automated stock replenishment
- Business reporting and insights

## Database Schema

The system uses five main tables:

- **Products**: Stores product details including stock levels
- **Customers**: Maintains customer contact information
- **Orders**: Records customer orders and total amounts
- **Order_Details**: Tracks individual items within each order
- **Inventory_Logs**: Maintains history of all inventory changes

## Core Functionality

### Order Processing
- Create new orders for customers
- Add multiple products to orders with quantity validation
- Automatically update inventory when orders are placed
- Apply bulk discounts based on order quantity

### Inventory Management
- Track current stock levels for all products
- Log all inventory changes (sales, replenishments)
- Identify products that need restocking
- Automated replenishment of low stock items

### Business Insights
- Customer spending analysis and categorization
- Order history reporting
- Low stock alerts
- Inventory movement tracking

## Project Phases

### Phase 1: Database Design
- Created database schema with tables and relationships
- Implemented referential integrity constraints

### Phase 2: Order Processing
- Developed order placement procedures
- Implemented inventory tracking on order placement
- Created transaction handling for data integrity

### Phase 3: Reporting Features
- Built order history queries
- Developed customer analysis features
- Implemented low stock detection

### Phase 4: Automation
- Created stock replenishment procedures
- Implemented automated low stock detection
- Added scheduled events for routine tasks

### Phase 5: Optimization
- Created views for simplified data access
- Added indexes for performance optimization
- Implemented transaction control for data integrity

## Advanced Features

- **Customer Tiering**: Bronze/Silver/Gold based on spending
- **Bulk Discounts**: Automatic price adjustments for large orders
- **Automated Reporting**: Scheduled generation of key business metrics
- **Stock Alerts**: Notification system for low inventory
- **Order History**: Complete tracking of all customer purchases


## Future Enhancements

- Web interface for admin access
- Customer portal for order placement
- Mobile app integration
- Payment processing integration
- Advanced analytics dashboard

---

This project was developed as part of an e-commerce database management solution to demonstrate relational database design, stored procedures, triggers, and business logic implementation using SQL.
