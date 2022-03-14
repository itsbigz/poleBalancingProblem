function acc = getAngleAccelaration(g, angle_theta, angle_velo, F, m_p, m_c, l)
    acc = g * sin(angle_theta) + cos(angle_theta)*((-F - m_p*l*angle_velo*angle_velo*sin(angle_theta))/(m_c+m_p));
    acc = acc/(l*(4/3 - m_p*cos(angle_theta)*cos(angle_theta)/(m_c+m_p)));
end