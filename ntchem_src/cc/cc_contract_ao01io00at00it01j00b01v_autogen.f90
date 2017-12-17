      SUBROUTINE  CC_Contract_Ao01Io00At00It01J00B01V_AutoGen &
      &   (V, T, W, nAo, nIo, nAt, nIt, nB, nJ, mCK, mB, mJ, mAo, mIo, mD, mL, mAn, mIn)
!
!     o This is an automatically generated program
!
!     Contract intermediate V(C,K,B,J,Ao,Io) to T(D,L)
!     to generate a new intermediate W(C,K,An,In)
!
      USE CC_Module, ONLY : NOc, NVr
      USE CC_Constant_Module, ONLY : One
      IMPLICIT DOUBLE PRECISION(A-H, O-Z)
!
      LOGICAL:: COIN
      REAL(8):: V(mCK,mB*mJ,mAo,mIo), T(mD,mL), W(mCK,mAn,mIn), F(mB,mJ), Alpha
      INTEGER:: NStringB(nB), NStringJ(nJ), NStringD(nB+nAt), NStringL(nJ+nIt)
      INTEGER:: NStringAt(nAt), NStringIt(nIt), NStringAo(nAo), NStringIo(nIo), NStringAn(nAo+nAt), NStringIn(nIo+nIt)



      DO iIt00 =  1, NOc   ! loop over external hole(s) in T-vertex
         NStringIt( 1) = iIt00

            CALL CCLib_DClear(F, mB*mJ)
               IAddJ = 1

               CALL CCLib_StringAddress(NStringIt, nIt, "Occ", IAddIt)
               ISgnL = 1
               IAddL = IAddIt


               DO iB00 =  1, NVr   ! loop over fixed particle(s)
                  NStringB( 1) = iB00
                  CALL CCLib_StringAddress(NStringB, nB, "Vir", IAddB)
                  ISgnD = 1
                  IAddD = IAddB
                  F(IAddB,IAddJ) = DBLE(ISgnL * ISgnD) * T(IAddD,IAddL)


               END DO  ! Fixed particles
               IAddIo = 1
               CALL CCLib_StringAddress(NStringIt, nIt, "Occ", IAddIt)
               ISgnIn = 1
               IAddIn = IAddIt


               DO iAo00 =  1, NVr   ! loop over external particle(s) in V
                  NStringAo( 1) = iAo00
                  CALL CCLib_StringAddress(NStringAo, nAo, "Vir", IAddAo)
                  ISgnAn = 1
                  IAddAn = IAddAo
                  Alpha = DBLE(ISgnAn * ISgnIn)
                  CALL DGEMV("N", mCK, mB*mJ, Alpha, V(1,1,IAddAo,IAddIo), mCK, F, 1, One, W(1,IAddAn,IAddIn), 1)


               END DO  ! V ext. particles


         END DO  ! T ext. holes
!
      END SUBROUTINE
