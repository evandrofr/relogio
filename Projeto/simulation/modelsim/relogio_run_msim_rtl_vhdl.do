transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/borg/Documents/relogio/Projeto/Components/ULA.vhd}
vcom -93 -work work {/home/borg/Documents/relogio/Projeto/Components/registradorGenerico.vhd}
vcom -93 -work work {/home/borg/Documents/relogio/Projeto/Components/muxGenerico2x1.vhd}
vcom -93 -work work {/home/borg/Documents/relogio/Projeto/Components/memoriaROM.vhd}
vcom -93 -work work {/home/borg/Documents/relogio/Projeto/Components/bancoRegistradoresArqRegMem.vhd}
vcom -93 -work work {/home/borg/Documents/relogio/Projeto/Components/unidControl.vhd}
vcom -93 -work work {/home/borg/Documents/relogio/Projeto/Components/somaConstante.vhd}
vcom -93 -work work {/home/borg/Documents/relogio/Projeto/processador.vhd}

