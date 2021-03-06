      SUBROUTINE  CC_ReArrange_B01J00D01L02X_AutoGen  &
      &   (V, V_, nB, nJ, nD, nL, mAI, mB, mJ, mD, mL, mC, mK)
!
!     o This is an automatically generated program
!
!     Re-arranges the array in the form (D,L,AI) to the form (C,K,B,J,AI)
!     nB, nJ, ...; # of occupations
!     mB, mJ, ...: # of all possible strings
!
      USE CC_Module, ONLY : NOc, NVr, IArcWgtOcc, IArcWgtVir
!
      IMPLICIT NONE
!
      INTEGER :: nB, nJ, nD, nL, mAI, mB, mJ, mD, mL, mC, mK
      REAL(8):: V(mD,mL,mAI), V_(mC,mK,mB,mJ,mAI)
!
      LOGICAL :: COIN
      INTEGER :: NStringB(nB)
      INTEGER :: NStringK(nL-nJ)
!
      INTEGER :: nC, nK, jB
      INTEGER :: IAddJ
      INTEGER :: IAddB
      INTEGER :: IAddK
      INTEGER :: IAddC
      INTEGER :: IAddKJ
      INTEGER :: IAddCB
      INTEGER :: ISgnKJ
      INTEGER :: ISgnCB
      INTEGER :: iAI
      INTEGER :: iB00, IAddB00
      INTEGER :: iB01, IAddB01
      INTEGER :: iK00, IAddK00
      INTEGER :: iK01, IAddK01
      INTEGER :: iK02, IAddK02
      CALL CCLib_DClear(V_, mC*mK*mB*mJ*mAI)
      nK = nL - nJ
      nC = nD - nB
      DO iAI = 1, mAI

            IAddJ = 1

            iB00 = 0
            IAddB00 = 1
            DO iB01 = iB00 + 1, NVr - nB +  1
               NStringB( 1) = iB01
               IAddB01 = IAddB00 + IArcWgtVir(iB01,  1, nB)
               IAddB = IAddB01

               iK00 = 0
               IAddK00 = 1
               Lp_iK01: DO   iK01 = iK00 + 1, NOc - nK +  1
                  NStringK( 1) = iK01
                  IAddK01 = IAddK00 + IArcWgtOcc(iK01,  1, nK)
               Lp_iK02: DO   iK02 = iK01 + 1, NOc - nK +  2
                  NStringK( 2) = iK02
                  IAddK02 = IAddK01 + IArcWgtOcc(iK02,  2, nK)
                  IAddK = IAddK02
                  ISgnKJ = 1
                  IAddKJ = IAddK
!
!     --- Get sign and Address of string B ---
!
                     IAddC = 1
                     ISgnCB = 1
                     IAddCB = IAddB
!
!     --- Rearrange the intermediate ---
!
                     V_(IAddC,IAddK,IAddB,IAddJ,iAI) = V(IAddCB,IAddKJ,iAI) * DBLE(ISgnCB * ISgnKJ)
               END DO Lp_iK02  ! Free internal holes
               END DO Lp_iK01
            END DO    ! Fixed internal particles
      END DO    ! External indices
!
      END SUBROUTINE
