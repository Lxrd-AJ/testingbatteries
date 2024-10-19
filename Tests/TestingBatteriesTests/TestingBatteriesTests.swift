import Testing
import TestingBatteries

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

struct LitmusTest: TestBatteries {
    @Test func canVerifyEquals() async throws {
        let x1: [Int] = [1, 2, 3]
        self.verifyEqual(x1, x1)
    }
}
