      SUBROUTINE  CC_Contract_Ao01Io02At02It01J01B00S_AutoGen &
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


         DO iAt00 =  2, NVr   ! loop over external particle(s) in T-vertex
            NStringAt( 2) = iAt00
         DO  iAt01 =  1, iAt00 - 1
            NStringAt( 1) =  iAt01

            CALL CCLib_DClear(F, mB*mJ)


            DO iJ00 =  1, NOc    ! loop over fixed hole(s)
               NStringJ( 1) = iJ00
               COIN = .FALSE.
               CALL CCLib_MergeStrings(NStringJ, NStringIt, NStringL, nJ, nIt, ISgnL, COIN)
               IF (COIN) CYCLE
               CALL CCLib_StringAddress(NStringL, nJ+nIt, "Occ", IAddL)
               CALL CCLib_StringAddress(NStringJ, nJ, "Occ", IAddJ)
                  IAddB = 1

                  CALL CCLib_StringAddress(NStringAt, nAt, "Vir", IAddAt)
                  ISgnD = 1
                  IAddD = IAddAt
                  F(IAddB,IAddJ) = DBLE(ISgnL * ISgnD) * T(IAddD,IAddL)


            END DO  ! Fixed holes


            DO iIo00 =  2, NOc    ! loop over external hole(s) in V
               NStringIo( 2) = iIo00
            DO  iIo01 =  1, iIo00 - 1
               NStringIo( 1) =  iIo01
               COIN = .FALSE.
               CALL CCLib_MergeStrings(NStringIo, NStringIt, NStringIn, nIo, nIt, ISgnIn, COIN)
               IF (COIN) CYCLE
               CALL CCLib_StringAddress(NStringIn, nIo+nIt, "Occ", IAddIn)
               CALL CCLib_StringAddress(NStringIo, nIo, "Occ", IAddIo)


               DO iAo00 =  1, NVr   ! loop over external particle(s) in V
                  NStringAo( 1) = iAo00
                  COIN = .FALSE.
                  CALL CCLib_MergeStrings(NStringAo, NStringAt, NStringAn, nAo, nAt, ISgnAn, COIN)
                  IF (COIN) CYCLE
                  CALL CCLib_StringAddress(NStringAn, nAo+nAt, "Vir", IAddAn)
                  CALL CCLib_StringAddress(NStringAo, nAo, "Vir", IAddAo)
                  Alpha = DBLE(ISgnAn * ISgnIn)
                  CALL DGEMV("N", mCK, mB*mJ, Alpha, V(1,1,IAddAo,IAddIo), mCK, F, 1, One, W(1,IAddAn,IAddIn), 1)


               END DO  ! V ext. particles


            END DO  ! V ext. holes
            END DO


         END DO  ! T ext. holes


      END DO  ! T ext. particles
      END DO
!
      END SUBROUTINE
