function jacob = compute_jacobian(vertices,dervals_psi)
    v = transpose(vertices);
    dervals = transpose(dervals_psi);
    jacob = v * dervals;
end
