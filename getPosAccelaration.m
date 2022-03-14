function acc = getPosAccelaration(F, m_p, l, angle_velo, angle_theta, angle_acc, m_c)
    acc = (F + m_p*l*(angle_velo*angle_velo*sin(angle_theta) - angle_acc*cos(angle_theta)))/(m_c + m_p);
end