# Bunch of declarations from C to python. The idea here is to define only the
# quantities that will be used, for input, output or intermediate manipulation,
# by the python wrapper. For instance, in the precision structure, the only
# item used here is its error message. That is why nothing more is defined from
# this structure. The rest is internal in Class.
# If, for whatever reason, you need an other, existing parameter from Class,
# remember to add it inside this cdef.

cdef extern from "class.h":

    ctypedef char FileArg[40]

    ctypedef char* ErrorMsg
  
    cdef struct precision:
        ErrorMsg error_message

    cdef struct background:
        ErrorMsg error_message
        int bg_size
        int index_bg_ang_distance
        int index_bg_conf_distance
        int index_bg_H
        short long_info
        short inter_normal
        double T_cmb
        double h
        double age
        double conformal_age
        double * m_ncdm_in_eV
        double Neff
        double Omega0_b
        double Omega0_cdm
        double Omega0_ncdm_tot
        double Omega0_lambda
        double Omega0_fld
        double w0_fld
        double wa_fld
        double cs2_fld

    cdef struct thermo:
        ErrorMsg error_message
        int th_size
        int index_th_xe
        int index_th_Tb
        short inter_normal
        double tau_reio
        double z_reio
        double z_rec
        double tau_rec
        double rs_rec
        double ds_rec
        double da_rec
        double z_d
        double tau_d
        double ds_d
        double rs_d
        double YHe
        double n_e

    cdef struct perturbs:
        ErrorMsg error_message
        int has_pk_matter

    cdef struct transfers:
        ErrorMsg error_message

    cdef struct primordial:
        ErrorMsg error_message
        double k_pivot
        double A_s
        double n_s
        double alpha_s
        double beta_s
        double r
        double n_t
        double alpha_t
        double V0
        double V1
        double V2
        double V3
        double V4
        double f_cdi
        double n_cdi
        double c_ad_cdi
        double n_ad_cdi
        double f_nid
        double n_nid
        double c_ad_nid
        double n_ad_nid
        double f_niv
        double n_niv
        double c_ad_niv
        double n_ad_niv
        double phi_min
        double phi_max

    cdef struct spectra:
        ErrorMsg error_message
        int l_max_tot
        int ln_k_size
        int ct_size
        int index_ct_tt
        int index_ct_te
        int index_ct_ee
        int index_ct_bb
        int index_ct_pp
        int index_ct_tp
        double* ln_k
        double sigma8
        double alpha_II_2_20
        double alpha_RI_2_20
        double alpha_RR_2_20
        double alpha_II_21_200
        double alpha_RI_21_200
        double alpha_RR_21_200
        double alpha_II_201_2500
        double alpha_RI_201_2500
        double alpha_RR_201_2500
        double alpha_II_2_2500
        double alpha_RI_2_2500
        double alpha_RR_2_2500
        double alpha_kp
        double alpha_k1
        double alpha_k2

    cdef struct output:
        ErrorMsg error_message

    cdef struct lensing:
        int index_lt_tt
        int index_lt_te
        int index_lt_ee
        int index_lt_bb
        int index_lt_pp
        int index_lt_tp
        int lt_size
        int has_lensed_cls
        int l_lensed_max
        int l_unlensed_max
        ErrorMsg error_message

    cdef struct nonlinear:
        int method
        ErrorMsg error_message

    cdef struct file_content:
        char * filename
        int size
        FileArg * name
        FileArg * value
        short * read

    void lensing_free(void*)
    void spectra_free(void*)
    void transfer_free(void*)
    void primordial_free(void*)
    void perturb_free(void*)
    void thermodynamics_free(void*)
    void background_free(void*)
    void nonlinear_free(void*)

    cdef int _FAILURE_
    cdef int _FALSE_
    cdef int _TRUE_

    int input_init(void*, void*, void*, void*, void*, void*, void*, void*, void*,
        void*, void*, char*)
    int background_init(void*,void*)
    int thermodynamics_init(void*,void*,void*)
    int perturb_init(void*,void*,void*,void*)
    int primordial_init(void*,void*,void*)
    int transfer_init(void*,void*,void*,void*,void*)
    int spectra_init(void*,void*,void*,void*,void*,void*)
    int nonlinear_init(void*,void*,void*,void*,void*,void*,void*,void*)
    int lensing_init(void*,void*,void*,void*,void*)

    int background_tau_of_z(void* pba, double z,double* tau)
    int background_at_tau(void* pba, double tau, short return_format, short inter_mode, int * last_index, double *pvecback)
    int thermodynamics_at_z(void * pba, void * pth, double z, short inter_mode, int * last_index, double *pvecback, double *pvecthermo)
    int spectra_cl_at_l(void* psp,double l,double * cl,double * * cl_md,double * * cl_md_ic)
    int lensing_cl_at_l(void * ple,int l,double * cl_lensed)
    int spectra_pk_at_z(
        void * pba,
        void * psp,
        int mode,
        double z,
        double * output_tot,
        double * output_ic
        )

    int spectra_pk_at_k_and_z(
        void* pba,
        void * ppm,
        void * psp,
        double k,
        double z,
        double * pk,
        double * pk_ic)

    int nonlinear_pk_at_z(
        void * pnl,
        double z,
        double * pz_density,
        double * pz_velocity,
        double * pz_cross,
        int * k_size_at_z)

    int nonlinear_pk_at_k_and_z(
        void * pnl,
        double k,
        double z,
        double * pz_density,
        double * pz_velocity,
        double * pz_cross,
        int * k_size_at_z)

    int nonlinear_k_nl_at_z(void* pnl, double z, double* k_nl)

    cdef enum linear_or_logarithmic:
        linear
        logarithmic