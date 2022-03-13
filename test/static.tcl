#===============================================================================
# Static load-controlled analysis input script
# Generated 13-Mar-2022 04:04:04
#
# Units: kip, inch, s
#===============================================================================
package require OpenSeesComposite


#-------------------------------------------------------------------------------
# Model script
#-------------------------------------------------------------------------------
<Model script>

#-------------------------------------------------------------------------------
# Applied loads
#-------------------------------------------------------------------------------
timeSeries Linear 1
pattern Plain 1 1 {
    load 0 0.0 1.0 0.0
}

#-------------------------------------------------------------------------------
# Recorders
#-------------------------------------------------------------------------------
<Recorders>

record


#===============================================================================
# Run the analysis!
#===============================================================================
constraints Plain
numberer RCM
system UmfPack
test NormDispIncr ...
algorithm KrylovNewton
integrator LoadControl ...
analysis Static

set name {[staticAnalysis]}

while { [getTime] < 1.0 } {
    set err [analyze 1]
    if { $err != 0 } {
        puts "$name ERROR: Analysis failed to converge"
        exit 2
    }
}
puts "$name Analysis successful. Terminating."
exit 1
