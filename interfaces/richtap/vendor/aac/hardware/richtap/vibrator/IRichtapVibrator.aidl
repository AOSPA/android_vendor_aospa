
package vendor.aac.hardware.richtap.vibrator;

import vendor.aac.hardware.richtap.vibrator.IRichtapCallback;

@VintfStability
interface IRichtapVibrator {

   /**
     * init richtap
     *
     * @param void
     * @return boolean
     */
    oneway void init(in IRichtapCallback callback);
	
	 /**
     * setting pattern mode dynamic scale
     *
     * @param scale value (from 0 to 100)
     * @return whether setDynamicScale was successful or not.
     */
    oneway void setDynamicScale(in int scale,in IRichtapCallback callback);


    /**
     * setting f0 param
     *
     * @param f0 value
     * @return whether vibrator command was successful or not.
     */
    oneway void setF0(in int f0,in IRichtapCallback callback);

    /**
     * stop interface for short latency
     * @param out current index for pattern or 0 for other mode
     */
    oneway void stop(in IRichtapCallback callback);
	
	/**
     * setAmplitude interface for change amplitude
     * @param out current index for pattern or 0 for other mode
     */
	oneway void setAmplitude(in int amplitude,in IRichtapCallback callback);
	
	  /**
     * he mode interface
     *
     * @param he param
     * @return whether vibrator command was successful or not.
     */
    oneway void performHeParam(in int interval, in int amplitude, in int freq,in IRichtapCallback callback);
	
    /**
     * off interface
     *
     * @param 
     * @return off ,do nothing
     */
	oneway void off(in IRichtapCallback callback);
	
	/**
     * vibrator on
     *
     * @param time out ms
     * @return cmd id.
     */
	oneway void on(in int timeoutMs,in IRichtapCallback callback);
	/**
     * perform prebak
     *
     * @param effect_id strength
     * @return cmd id.
     */
    int perform(in int effect_id, in byte strength,in IRichtapCallback callback);	
	
    /**
     * envelope parameter generate data
     *
     * @param envelope parameter pointer
     * @return cmd id.
     */
    oneway void performEnvelope(in int[] envInfo, in boolean fastFlag,in IRichtapCallback callback);

    /**
     * output based on voltage or accelerate signal
     * @param file description
     * @param cmd id.
     */
    oneway void performRtp(in ParcelFileDescriptor hdl,in IRichtapCallback callback);

    /**
     * he mode interface
     *
     * @param he parameter pointer
     * @param cmd id.
     */
    oneway void performHe(in int looper, in int interval, in int amplitude, in int freq, in int[] he,in IRichtapCallback callback);


    /**
     * interface that's for DRC parameters setting, etc.
     *
     * @param parameters
     * @param length of parameters.
     */
    oneway void setHapticParam(in int[] data, in int length, in IRichtapCallback callback);
}
