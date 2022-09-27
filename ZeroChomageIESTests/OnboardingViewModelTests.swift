//
//  OnboardingViewModelTests.swift
//  OnboardingViewModelTests
//
//  Created by Saddam Satouyev on 10/10/2021.
//

import XCTest
@testable import ZeroChomageIES

class OnboardingViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        UserDefaultsManager.shared.setHasSeenOnboarding(value: false)
        
    }


    func test_givenSlideIndex0_whenIncrementSlideIndex_thenEqual1() throws {
        
        let sut = OnboardingViewModel()
        
        XCTAssertEqual(sut.currentSlideIndex, 0)
        
        sut.incrementSlideIndex()
      
        XCTAssertEqual(sut.currentSlideIndex, 1)
    }
    
    
    func test_givenSlideIndexIs0_whenGettingIsLastSlide_thenFalse() throws {
        
        let sut = OnboardingViewModel()
      
        XCTAssertFalse(sut.isLastSlide)
    }
    
    
    func test_givenSlideIndexIsLast_whenGettingIsLastSlide_thenTrue() throws {
        
        let sut = OnboardingViewModel()
        
        sut.incrementSlideIndex()
        sut.incrementSlideIndex()
        sut.incrementSlideIndex()
      
        XCTAssertTrue(sut.isLastSlide)
        
        
    }
    
    
    func test_givenOnboarding_whenFinishOnboarding_thenHasSeenOnBoardingTrue() throws {
        
        let sut = OnboardingViewModel()
        
        XCTAssertFalse(UserDefaultsManager.shared.getHasSeenOnboarding())
        
        sut.didFinishOnboarding()
        
        XCTAssertTrue(UserDefaultsManager.shared.getHasSeenOnboarding())
    }
    

}
