//
//  CartViewModelTests.swift
//  CartViewModelTests
//
//  Created by Ani's Mac on 03.12.23.
//

import XCTest
@testable import UnitTestingAssignment

final class CartViewModelTests: XCTestCase {
    
    var cartViewModel: CartViewModel!
    
    override func setUpWithError() throws {
        cartViewModel = CartViewModel()
    }
    
    override func tearDownWithError() throws {
        cartViewModel = nil
    }
    
    func testFetchProducts() {
        let expectation = self.expectation(description: "Fetch Products")
        cartViewModel.fetchProducts()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0 , execute: {
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5.0)
        
        XCTAssertEqual(cartViewModel.allProducts?.count, 30)
    }
    
    func testSelectedItemsQuantity() {
        let firstMockProduct = Product(id: 1, title: "First Mock Product", price: 10, selectedQuantity: 3)
        let secondMockProduct = Product(id: 1, title: "Second Mock Product", price: 20, selectedQuantity: 4)
        cartViewModel.selectedProducts = [firstMockProduct, secondMockProduct]
        XCTAssertEqual(cartViewModel.selectedItemsQuantity, 7)
    }
    
    func testTotalPrice() {
        let firstMockProduct = Product(id: 1, title: "First Mock Product", price: 10, selectedQuantity: 3)
        let secondMockProduct = Product(id: 1, title: "Second Mock Product", price: 20, selectedQuantity: 4)
        cartViewModel.selectedProducts = [firstMockProduct, secondMockProduct]
        XCTAssertEqual(cartViewModel.totalPrice, 3 * 10 + 4 * 20)
    }
    
    func testTotalPriceWhenSelectedQuantityIsZero() {
        let firstMockProduct = Product(id: 1, title: "First Mock Product", price: 10, selectedQuantity: 0)
        cartViewModel.selectedProducts = [firstMockProduct]
        XCTAssertEqual(cartViewModel.totalPrice, 0)
    }
    
    func testAddProductWithID() {
        let mockProduct = Product(id: 1, title: "Mock Product", price: 10, selectedQuantity: 1)
        cartViewModel.allProducts = [mockProduct]
        cartViewModel.addProduct(withID: 1)
        XCTAssertEqual(cartViewModel.selectedProducts.count, 1)
    }
    
    func testAddProduct() {
        let mockProduct = Product(id: 1, title: "Mock Product", price: 10, selectedQuantity: 1)
        cartViewModel.addProduct(product: mockProduct)
        XCTAssertEqual(cartViewModel.selectedProducts.count, 1)
    }
    
    func testAddProductWithNilQuantity() {
        let mockProduct = Product(id: 1, title: "Mock Product", price: 10, selectedQuantity: 0)
        cartViewModel.addProduct(product: mockProduct)
        XCTAssertEqual(cartViewModel.selectedProducts.count, 1) //0 უნდა იყოს და არა - 1
    }
   
    func testAddRandomProduct() {
        let firstMockProduct = Product(id: 1, title: "Mock Product", price: 10, selectedQuantity: 1)
        let secondMockProduct = Product(id: 2, title: "Mock Product", price: 10, selectedQuantity: 1)
        let thirdMockProduct = Product(id: 3, title: "Mock Product", price: 10, selectedQuantity: 1)
        cartViewModel.allProducts = [firstMockProduct, secondMockProduct, thirdMockProduct]
        cartViewModel.addRandomProduct()
        XCTAssertEqual(cartViewModel.selectedProducts.count, 1)
    }
    
    func testRemoveProduct() {
        let mockProduct = Product(id: 1, title: "Mock Product", price: 10, selectedQuantity: 1)
        cartViewModel.allProducts = [mockProduct]
        cartViewModel.removeProduct(withID: 1)
        XCTAssertEqual(cartViewModel.selectedProducts.count, 0)
    }
    
    func testClearCart() {
        let mockProduct = Product(id: 1, title: "Mock Product", price: 10, selectedQuantity: 1)
        cartViewModel.allProducts = [mockProduct]
        cartViewModel.clearCart()
        XCTAssertEqual(cartViewModel.selectedProducts.count, 0)
    }
}
