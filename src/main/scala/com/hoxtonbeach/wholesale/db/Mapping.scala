package com.hoxtonbeach.wholesale.db

import java.sql.Date

object Mapping {

  case class Address(line1: String,
                     line2: Option[String],
                     line3: Option[String],
                     line4: Option[String],
                     postcode: String)

  case class Product(name: String,
                     barcode: String,
                     wspPence: Int,
                     rrpPence: Int)

  case class OrderLine(product: Product, count: Int)

  type OrderSet = Set[OrderLine]

  case class Customer(id: String, name: String, billingAddress: Address)

  case class Contact(fName: String, surname: String, telephone: String, email: String)

  case class Shop(customer: Customer, deliveryAddress: Address, contact: Contact)

  case class Order(orderSet: OrderSet,
                   customer: Customer,
                   date: Date)

  object Order {
    def totalInPence(order: Order): Int = order.orderSet
      .view
      .map(l => l.count * l.product.wspPence)
      .sum
  }

  case class Invoice(number: String,
                     order: Order,
                     customer: Customer,
                     shop: Shop)

  object Invoice {
    def asHTML(invoice: Invoice) = "<hmtl/>"
    def asPDF(invoice: Invoice) = "PDF"
  }
}
