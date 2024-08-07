mod Test.Handler.ZeroShot.Int32 {

    eff Exc {
        pub def raise(): Int32
    }

    @Test
    def testLinear01(): Bool =
        def f1() = do Exc.raise();
        let result = try {
            f1()
        } with Exc {
            def raise(_k) = 42
        };
        Assert.eq(42, result)

    @Test
    def testLinear02(): Bool =
        def f1() = do Exc.raise();
        def f2() = { f1(); unreachable!() };
        let result = try {
            f2()
        } with Exc {
            def raise(_k) = 42
        };
        Assert.eq(42, result)

    @Test
    def testLinear03(): Bool =
        def f1() = do Exc.raise();
        def f2() = { f1(); unreachable!() };
        def f3() = { f2(); unreachable!() };
        let result = try {
            f3()
        } with Exc {
            def raise(_k) = 42
        };
        Assert.eq(42, result)

    @Test
    def testRecursiveLetRec01(): Bool =
        def f() = do Exc.raise();
        def r(x) = if (x == 0) f() else { r(x - 1); unreachable!() } ;
        let result = try {
            r(0)
        } with Exc {
            def raise(_k) = 42
        };
        Assert.eq(42, result)

    @Test
    def testRecursiveLetRec02(): Bool =
        def f() = do Exc.raise();
        def r(x) = if (x == 0) f() else { r(x - 1); unreachable!() } ;
        let result = try {
            r(1)
        } with Exc {
            def raise(_k) = 42
        };
        Assert.eq(42, result)

    @Test
    def testRecursiveLetRec03(): Bool =
        def f() = do Exc.raise();
        def r(x) = if (x == 0) f() else { r(x - 1); unreachable!() } ;
        let result = try {
            r(10)
        } with Exc {
            def raise(_k) = 42
        };
        Assert.eq(42, result)

    @Test
    def testMutualRecursive01(): Bool =
        let result = try {
            mutual1(0)
        } with Exc {
            def raise(_k) = 42
        };
        Assert.eq(42, result)

    @Test
    def testMutualRecursive02(): Bool =
        let result = try {
            mutual1(1)
        } with Exc {
            def raise(_k) = 42
        };
        Assert.eq(42, result)

    @Test
    def testMutualRecursive03(): Bool =
        let result = try {
            mutual1(2)
        } with Exc {
            def raise(_k) = 42
        };
        Assert.eq(42, result)

    @Test
    def testMutualRecursive04(): Bool =
        let result = try {
            mutual1(3)
        } with Exc {
            def raise(_k) = 42
        };
        Assert.eq(42, result)

    @Test
    def testMutualRecursive05(): Bool =
        let result = try {
            mutual1(10)
        } with Exc {
            def raise(_k) = 42
        };
        Assert.eq(42, result)

    def f(): Int32 \ Exc =
         do Exc.raise();
         unreachable!()

    def mutual1(x: Int32): Int32 \ Exc =
        if (x == 0) f() else { mutual2(x - 1); unreachable!() }

    def mutual2(x: Int32): Int32 \ Exc =
        if (x == 0) f() else { mutual1(x - 1); unreachable!() }

}
