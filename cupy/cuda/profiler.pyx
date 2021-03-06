"""Thin wrapper of cuda profiler."""
cimport cython

from cupy.cuda cimport runtime
from cupy.cuda import runtime


cdef extern from "cupy_cuda.h":
    runtime.Error cudaProfilerInitialize(const char *configFile, 
                                         const char *outputFile, 
                                         int outputMode)
    runtime.Error cudaProfilerStart()
    runtime.Error cudaProfilerStop()


cpdef void initialize(str config_file,
                      str output_file,
                      int output_mode) except *:
    """Initialize the CUDA profiler.

    This function initialize the CUDA profiler. See the CUDA document for
    detail.

    Args:
        config_file (str): Name of the configuration file.
        output_file (str): Name of the coutput file.
        output_mode (int): ``cupy.cuda.profiler.cudaKeyValuePair`` or
            ``cupy.cuda.profiler.cudaCSV``.
    """
    cdef bytes b_config_file = config_file.encode()
    cdef bytes b_output_file = output_file.encode()
    status = cudaProfilerInitialize(<const char*>b_config_file,
                                    <const char*>b_output_file,
                                    <OutputMode>output_mode)
    runtime.check_status(status)


cpdef void start() except *:
    """Enable profiling.

    A user can enable CUDA profiling. When an error occurs, it raises an
    exception.

    See the CUDA document for detail.
    """
    status = cudaProfilerStart()
    runtime.check_status(status)


cpdef void stop() except *:
    """Disable profiling.

    A user can disable CUDA profiling. When an error occurs, it raises an
    exception.

    See the CUDA document for detail.
    """
    status = cudaProfilerStop()
    runtime.check_status(status)
