MODULE paw

  USE kinds, ONLY: DP
  USE parameters, ONLY: nbrx, npsx, ndm
  !
  ! ... These parameters are needed for the paw variables
  !
  SAVE
  !
  REAL(KIND=DP) :: &
       paw_betar(0:ndm,nbrx,npsx)            ! radial beta_{mu} functions
  INTEGER :: &
       paw_nh(npsx),             &! number of beta functions per atomic type
       paw_nbeta(npsx),          &! number of beta functions
       paw_kkbeta(npsx),         &! point where the beta are zero
       paw_lll(nbrx,npsx)         ! angular momentum of the beta function
  INTEGER :: &
       paw_nhm,              &! max number of different beta functions per atom
       paw_nkb,              &! total number of beta functions, with st.fact.
       paw_nqxq,             &! size of interpolation table
       paw_lmaxkb,           &! max angular momentum
       paw_lqx,              &! max angular momentum + 1 for Q functions
       paw_nqx                ! number of interpolation points
  INTEGER, ALLOCATABLE ::&
       paw_indv(:,:),        &! correspondence of betas atomic <-> soli
       paw_nhtol(:,:),       &! correspondence n <-> angular momentum
       paw_nhtom(:,:),       &! correspondence n <-> magnetic angular m
       paw_nl(:,:),          &! number of projectors for each l
       paw_iltonh(:,:,:)        ! corresp l, num <--> n for each type
  complex(KIND=DP), ALLOCATABLE, TARGET :: &
       paw_vkb(:,:),         &   ! all beta functions in reciprocal space
       paw_becp(:,:)             !  products of wavefunctions and proj
  REAL(KIND=DP), ALLOCATABLE :: &
       paw_tab(:,:,:)              ! interpolation table for PPs
  !
  type wfc_label
     integer  :: na , &   ! Atom number
          nt ,        &   ! Type
          n  ,        &   ! Chi index
          l  ,        &   ! l
          m               ! m
  end type wfc_label

  type at_wfc
     type(wfc_label)          :: label
     integer                  :: kkpsi
!     real(kind=DP)            :: rmt   = 0.0_DP ! Like FLAPW or LMTO Muffin Tinradius
     real(kind=DP)  , pointer :: psi(:)
  end type at_wfc

  type(at_wfc),pointer :: aephi(:,:), psphi(:,:) ! Atom

CONTAINS

  subroutine paw_wfc_init(phi)
    type(at_wfc) :: phi(:,:)

    phi%label%na = 0
    phi%label%nt = 0
    phi%label%n  = 0
    phi%label%l  = -99
    phi%label%m  = -99
    phi%kkpsi    = 0

    return
  end subroutine paw_wfc_init


END MODULE paw








