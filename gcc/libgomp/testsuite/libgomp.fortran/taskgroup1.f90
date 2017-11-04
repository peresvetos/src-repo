  integer :: v(16), i
  do i = 1, 16
    v(i) = i
  end do

  !$omp parallel num_threads (4)
    !$omp single
      !$omp taskgroup
	do i = 1, 16, 2
	  !$omp task
	    !$omp task
	      v(i) = v(i) + 1
	    !$omp end task
	    !$omp task
	      v(i + 1) = v(i + 1) + 1
	    !$omp end task
	  !$omp end task
	end do
      !$omp end taskgroup
      do i = 1, 16
	if (v(i).ne.(i + 1)) call abort
      end do
      !$omp taskgroup
	do i = 1, 16, 2
	  !$omp task
	    !$omp task
	      v(i) = v(i) + 1
	    !$omp endtask
	    !$omp task
	      v(i + 1) = v(i + 1) + 1
	    !$omp endtask
	    !$omp taskwait
	  !$omp endtask
	end do
      !$omp endtaskgroup
      do i = 1, 16
	if (v(i).ne.(i + 2)) call abort
      end do
      !$omp taskgroup
	do i = 1, 16, 2
	  !$omp task
	    !$omp task
	      v(i) = v(i) + 1
	    !$omp end task
	    v(i + 1) = v(i + 1) + 1
	  !$omp end task
	end do
	!$omp taskwait
	do i = 1, 16, 2
	  !$omp task
	    v(i + 1) = v(i + 1) + 1
	  !$omp end task
	end do
      !$omp end taskgroup
      do i = 1, 16, 2
	if (v(i).ne.(i + 3)) call abort
	if (v(i + 1).ne.(i + 5)) call abort
      end do
      !$omp taskgroup
	do i = 1, 16, 2
	  !$omp taskgroup
	    !$omp task
	      v(i) = v(i) + 1
	    !$omp end task
	    !$omp task
	      v(i + 1) = v(i + 1) + 1
	    !$omp end task
	  !$omp end taskgroup
	  if (v(i).ne.(i + 4).or.v(i + 1).ne.(i + 6)) call abort
	  !$omp task
	    v(i) = v(i) + 1
	  !$omp end task
	end do
      !$omp end taskgroup
      do i = 1, 16
	if (v(i).ne.(i + 5)) call abort
      end do
    !$omp end single
  !$omp end parallel
end
