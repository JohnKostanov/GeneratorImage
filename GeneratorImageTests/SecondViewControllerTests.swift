//
//  SecondViewControllerTests.swift
//  GeneratorImageTests
//
//  Created by Джон Костанов on 1/6/23.
//

import XCTest
@testable import GeneratorImage

final class SecondViewControllerTests: XCTestCase {
    
    var secondVC: SecondViewController!
    
    override func setUp() {
        super.setUp()
        secondVC = SecondViewController()
    }
    
    override func tearDown() {
        secondVC = nil
        super.tearDown()
    }
    
    // Проверка заполнения массива allImages
    func testArrayAllImages() throws {
        let expectedArray = Array(repeating: UIImage(named: "image"), count: 5)
        let actualArray = fillArray()
        func fillArray() -> [UIImage?] {
            for image in repeatElement(UIImage(named: "image"), count: 5) {
                guard let image else {
                    continue
                }
                secondVC.addImageToFavorites(image)
            }
            return secondVC.favorites.allImages
        }
        XCTAssertEqual(expectedArray, actualArray)
    }
    
    // Проверка ограничения заполнения массива maxAmount для allImages
    func testArrayLimitForAllImages() throws {
        let expectedArray = Array(repeating: UIImage(named: "image"), count: 10)
        let actualArray = fillArray()
        func fillArray() -> [UIImage?] {
            for image in repeatElement(UIImage(named: "image"), count: 15) {
                guard let image else {
                    continue
                }
                secondVC.addImageToFavorites(image)
            }
            return secondVC.favorites.allImages
        }
        XCTAssertEqual(expectedArray, actualArray)
    }
}
