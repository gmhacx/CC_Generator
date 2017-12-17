      SUBROUTINE  CC_ContractGEMM_Ao00Io02At03It01S_AutoGen &
      &   (V, T, W, nAo, nIo, nAt, nIt, mCK, mBJ, mAo, mIo, mAt, mIt, mAn, mIn)
!
!     o This is an automatically generated program
!
!     Contract intermediate V(CK,BJ,Ao,Io) to T(BJ,At,It)
!     to generate a new intermediate W(C,K,An,In)
!
      USE CC_Module, ONLY : NOc, NVr, IArcWgtOcc, IArcWgtVir
      USE CC_Constant_Module, ONLY : One, Zero
!
      IMPLICIT NONE
!
      INTEGER :: nAo, nIo, nAt, nIt, mCK, mBJ, mAo, mIo, mAt, mIt, mAn, mIn
      REAL(8):: V(mBJ,mAo,mIo), T(mBJ,mAt,mIt), W(mAn,mIn)
!
      LOGICAL:: COIN
      REAL(8) :: Alpha
      INTEGER:: NStringAt(nAt), NStringIt(nIt), NStringAo(nAo), NStringIo(nIo), NStringAn(nAo+nAt), NStringIn(nIo+nIt)

      REAL(8), ALLOCATABLE :: U(:,:,:)
      INTEGER :: IAddIo
      INTEGER :: IAddAo
      INTEGER :: IAddIt
      INTEGER :: IAddAt
      INTEGER :: IAddIn
      INTEGER :: IAddAn
      INTEGER :: ISgnIn
      INTEGER :: ISgnAn
      INTEGER :: IAddAtIt
      INTEGER :: iIo00, IAddIo00
      INTEGER :: iIo01, IAddIo01
      INTEGER :: iIt00, IAddIt00
      INTEGER :: iAt00, IAddAt00
      INTEGER :: iAt01, IAddAt01
      INTEGER :: iAt02, IAddAt02
!
      ALLOCATE(U(mAt*mIt,mAo,mIo))
!
      CALL DGEMM("T", "N", (mAt*mIt), (mAo*mIo), mBJ, One, T, mBJ, V, mBJ, Zero, U, (mAt*mIt))
!
      DO iIo00 =  2, NOc   ! loop over external hole(s) in V
         NStringIo( 2) = iIo00
         IAddIo00 = 1 + IArcWgtOcc(iIo00,  2, nIo)
      DO  iIo01 =  1, iIo00 - 1
         NStringIo( 1) =  iIo01
         IAddIo01 = IAddIo00 + IArcWgtOcc(iIo01,  1, nIo)
         IAddIo = IAddIo01
!
            IAddAo = 1
!
            DO iIt00 =  1, NOc    ! loop over external hole(s) in V
               IF (iIt00 == iIo00) CYCLE
               IF (iIt00 == iIo01) CYCLE
               NStringIt( 1) = iIt00
               IAddIt00 = 1 + IArcWgtOcc(iIt00,  1, nIt)
               IAddIt = IAddIt00
               COIN = .FALSE.
               CALL CCLib_MergeStrings(NStringIo, NStringIt, NStringIn, nIo, nIt, ISgnIn, COIN)
               IF (COIN) CYCLE
               CALL CCLib_StringAddress(NStringIn, nIo+nIt, "Occ", IAddIn)
!
            DO iAt00 =  3, NVr   ! loop over external particle(s) in V
               NStringAt( 3) = iAt00
               IAddAt00 = 1 + IArcWgtVir(iAt00,  3, nAt)
            DO  iAt01 =  2, iAt00 - 1
               NStringAt( 2) =  iAt01
               IAddAt01 = IAddAt00 + IArcWgtVir(iAt01,  2, nAt)
            DO  iAt02 =  1, iAt01 - 1
               NStringAt( 1) =  iAt02
               IAddAt02 = IAddAt01 + IArcWgtVir(iAt02,  1, nAt)
               IAddAt = IAddAt02
               ISgnAn = 1
               IAddAn = IAddAt
!
                  Alpha = DBLE(ISgnAn * ISgnIn)
                  IAddAtIt = mAt * (IAddIt - 1) + IAddAt
                  W(IAddAn,IAddIn) = W(IAddAn,IAddIn) + Alpha * U(IAddAtIt,IAddAo,IAddIo)
!
               END DO  ! T ext. particles
               END DO
               END DO
!
            END DO  ! T ext. holes
!
      END DO  ! V ext. holes
      END DO
      DEALLOCATE(U)
!
      END SUBROUTINE
