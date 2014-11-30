/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 30/11/2014 10:40
 */
package eu.alebianco.air.extensions.analytics.demo.model {
public class TestStats {

    private var _testCount:uint;
    private var _testsCompleted:uint;
    private var _testsPassed:uint;
    private var _testsFailed:uint;
    private var _testsIgnored:uint;

    public function TestStats(testCount:uint) {
        _testCount = testCount;
    }

    public function addSuccessful():void {
        _testsPassed += 1;
        _testsCompleted += 1;
    }

    public function addFailure():void {
        _testsFailed += 1;
        _testsCompleted += 1;
    }

    public function addIgnored():void {
        _testsIgnored += 1;
        _testsCompleted += 1;
    }

    public function get total():uint {
        return _testCount;
    }

    public function get completed():uint {
        return _testsCompleted;
    }

    public function get passed():uint {
        return _testsPassed;
    }

    public function get failed():uint {
        return _testsFailed;
    }

    public function get ignored():uint {
        return _testsIgnored;
    }
}
}
