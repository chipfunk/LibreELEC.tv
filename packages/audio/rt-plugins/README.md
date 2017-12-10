# rt-plugins

http://faculty.tru.ca/rtaylor/rt-plugins/index.html


## Pulseaudio integration

The integration for the LADSPA-plugins is realized by using the pulseaudio-module "module-ladspa-sink".

An example for a two-way crossover is shown in the example below. Setting up pulseaudio has to be done in "reverse order", walking the audio-path backwards from sound-card to source, making sure the required sinks are known to pulseaudio when referencing them.

    # loading alsa-module to create target-sink "alsa_output.plughw_1_0"
    pactl load-module module-alsa-sink device=plughw:1,0 tsched=0

    # define highpass-filter and channel-mapping for output-device
    pactl load-module module-ladspa-sink sink_name=highpass master=alsa_output.plughw_1_0 channel_map=front-left,front-right plugin=RTlr4hipass label=RTlr4hipass control=93.0

    # define lowpass-filter and channel-mapping for output-device
    pactl load-module module-ladspa-sink sink_name=lowpass master=alsa_output.plughw_1_0 channel_map=rear-left,rear-right plugin=RTlr4lowpass label=RTlr4lowpass control=93.0

    # create sink "two_way_crossover" for spliting stereo-input on the two different filter-paths
    pactl load-module module-combine-sink sink_name=two_way_crossover slaves=highpass,lowpass adjust_time=1

    # set sink "two_way_crossover" to be used by default
    pactl set-default-sink two_way_crossover
    

To apply the settings on startup place the above code in

    /storage/.config/autostart.sh


### Filter-examples

The following code shows how to load the provided LADSPA-plugins into your pulseaudio-setup.


#### 1st-order low-pass, -3dB at fc

    pactl load-module module-ladspa-sink sink_name=<:filter_sink_name> master=<:target_sink_name> plugin=RTlowpass1 label=RTlowpass1 control=<:freq>


#### 1st-order high-pass, -3dB at fc

    pactl load-module module-ladspa-sink sink_name=<:filter_sink_name> master=<:target_sink_name> plugin=RThighpass1 label=RThighpass1 control=<:freq>

    
#### 2nd-order low-pass, -3dB at fc

    pactl load-module module-ladspa-sink sink_name=<:filter_sink_name> master=<:target_sink_name> plugin=RTlowpass label=RTlowpass control=<:freq>,<:q>

    
#### 2nd-order high-pass, -3dB at fc

    pactl load-module module-ladspa-sink sink_name=<:filter_sink_name> master=<:target_sink_name> plugin=RThighpass label=RThighpass control=<:freq>,<:q>


#### Linkwitz-Riley 4th-order low-pass, -6dB at fc

    pactl load-module module-ladspa-sink sink_name=<:filter_sink_name> master=<:target_sink_name> plugin=RTlr4lowpass label=RTlr4lowpass control=<:freq>

    
#### Linkwitz-Riley 4th-order high-pass, -6dB at fc

    pactl load-module module-ladspa-sink sink_name=<:filter_sink_name> master=<:target_sink_name> plugin=RTlr4hipass label=RTlr4hipass control=<:freq>


#### Low shelving (unity gain at high frequency)

    pactl load-module module-ladspa-sink sink_name=<:filter_sink_name> master=<:target_sink_name> plugin=RTlowshelf label=RTlowshelf control=<:gain>,<:freq>,<:q>


#### High shelving (unity gain at low frequency)

    pactl load-module module-ladspa-sink sink_name=<:filter_sink_name> master=<:target_sink_name> plugin=RThighshelf label=RThighshelf control=<:gain>,<:freq>,<:q>


#### Parametric eq (notch/peak) at fc

    pactl load-module module-ladspa-sink sink_name=<:filter_sink_name> master=<:target_sink_name> plugin=RTparaeq label=RTparaeq control=<:gain>,<:freq>,<:q>


#### 1st-order all-pass (non-inverting)

    pactl load-module module-ladspa-sink sink_name=<:filter_sink_name> master=<:target_sink_name> plugin=RTallpass1 label=RTallpass1 control=<:freq>

    
#### 2nd-order all-pass (non-inverting)

    pactl load-module module-ladspa-sink sink_name=<:filter_sink_name> master=<:target_sink_name> plugin=RTallpass2 label=RTallpass2 control=<:freq>,<:q>
