import h5py

with h5py.File("211.hdf5", "r") as originF, h5py.File("fitsets_red.hdf5", "a") as FitFile:
    pcaGroup = FitFile.require_group(f"test211_redux")
    chunklen=100
    mask=originF["Trajectories/211_T_700/Trajectory"][0,:,2]>-1
    data=originF["SOAP/211_T_700"][:][:,mask,:]
    #data=originF["SOAPFitSet/test210"]
    pcaout = pcaGroup.require_dataset(
            "SOAPFitSet",
            shape=(data.shape[0]*data.shape[1],data.shape[2]),
            dtype=data.dtype,
            chunks=(chunklen, data.shape[2]),
            compression="gzip",
        )
    pcaout[:]=data[:].reshape(pcaout.shape)
    
