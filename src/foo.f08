SUBROUTINE foo(x, y, z)
    IMPLICIT NONE
    INTEGER, INTENT(IN)  :: x, y
    INTEGER, INTENT(OUT) :: z
    z = x + y
END

