import h5py

with h5py.File("210.hdf5", "r") as originF, h5py.File("fitsets_red.hdf5", "a") as FitFile:
    pcaGroup = FitFile.require_group(f"test210_redux")
    chunklen=100
    mask=originF["Trajectories/210_T_500/Trajectory"][0,:,2]>-1
    data=originF["SOAP/210_T_500"][:][:,mask,:]
    #data=originF["SOAPFitSet/test210"]
    pcaout = pcaGroup.require_dataset(
            "SOAPFitSet",
            shape=(data.shape[0]*data.shape[1],data.shape[2]),
            dtype=data.dtype,
            chunks=(chunklen, data.shape[2]),
            compression="gzip",
        )
    pcaout[:]=data[:].reshape(pcaout.shape)
    
