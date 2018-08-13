import XCTest
import RxSwift
import rxObservableCollectionWithObservableElement

class Tests: XCTestCase {
	
	final class TestModel:NotifyChanged{
		var elementChanged: PublishSubject<(keyPath: AnyKeyPath, old: Any, new: Any)>
		
		var string:String
		var int:Int
		var money: Double
		init(string:String,int:Int, money:Double) {
			self.string = string
			self.int = int
			
			self.money = money
			
			
			elementChanged = PublishSubject<(keyPath: AnyKeyPath, old: Any, new: Any)>()
		}
	}
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
	
	
	func testObservableInserts(){
		let dp = DisposeBag()
		
		var obsCollection = ObservableCollection<TestModel>()
		
		var element = TestModel(string: "", int: 0, money: 0.0)
		obsCollection.rx.subscribe(onNext: { (tuple) in
			switch tuple.event{
				case .insertedIndices(let indices):
				assert(indices[0] == 0)
				assert(tuple.element[0].money == element.money && tuple.element[0].string == element.string, "the elements are not the same" )
				break
				default:
				assert(false, "this is not an inser event")
			}
		}).disposed(by: dp)
		
		obsCollection.append(element)
	}
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
}



