#include <asm/regdef.h>
#include <asm/cp0regdef.h>
#include <asm/asm.h>

LEAF(tlb_out)
//1: j 1b
nop
	mtc0	a0,CP0_ENTRYHI
	nop
	tlbp
	nop
	mfc0	k0,CP0_INDEX
	bltz	k0,NOFOUND
	nop
		mtc0	zero,CP0_ENTRYLO0
		nop
		tlbwi

NOFOUND:
	j	ra
	nop
END(tlb_out)
