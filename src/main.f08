PROGRAM main
    IMPLICIT NONE
    INTEGER :: x, y, z

    x = 1
    y = 1

    CALL foo(x, y, z)

    PRINT *, "main.f08::", x, "+", y, "=", z
END PROGRAM main
